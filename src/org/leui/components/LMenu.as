package org.leui.components
{
	
	import flash.display.InteractiveObject;
	
	import org.leui.core.IPopup;
	import org.leui.events.LEvent;
	import org.leui.events.LStageEvent;
	import org.leui.layouts.MenuLayout;
	import org.leui.utils.LUIManager;
	import org.leui.utils.UiConst;
	import org.leui.vos.MenuItemVO;

	/**
	 *   LMenu 控件创建可分别选择的选项的弹出菜单，弹出菜单可以具有所需的任何数目的子菜单级别。
	 * 菜单及子菜单的创建通过MenuItemVO数据集实现，具体请参考LeUI-book中的示例。
	 * 打开 Menu 控件后，此控件将一直可见，直到通过下列任一操作将其关闭：
	 * </br>1.调用 LMenu.hide() 方法。
	 * </br>2.用户点选已启用的菜单项。
	 * </br>3.用户在 Menu 控件外部单击。 
	 *@author swellee
	 */
	public class LMenu extends LList implements IPopup
	{
		private var _isPrimary:Boolean;
		private var menuItemVos:Vector.<MenuItemVO>;
		private var subMenu:LMenu;
		private var menuInvoker:MenuInvoker;
		/**
		 *是否允许invoker重复点击时，重置menu的位置 
		 */
		private var allowInvokerReclick:Boolean;
		/**
		 *弹出点坐标X 
		 */
		public var popX:int;
		/**
		 *弹出点坐标Y 
		 */
		public var popY:int;
		private var menuItemClickHandler:Function;

		/**
		 *  菜单 ，推荐使用静态函数LMenu.createMenu()创建菜单。
		 * 若使用构造函数实例化，应手动调用以下两个函数设置菜单数据：setInvoker()、setMenuData()
		 * @see LMenu.setInvoker()
		 * @see LMenu.setMenuData()
		 * @see LMenu.createMenu()
		 */
		public function LMenu()
		{
			super(0, UiConst.MENU_ITEM_GAP, true);
		}
		
		public function get isPrimary():Boolean
		{
			return _isPrimary;
		}
		
		public function get isShowing():Boolean
		{
			return null!=parent;
		}
		
		public function hide(disposeThis:Boolean=false):void
		{
			if(parent)
			{
				parent.removeChild(this);
				if(subMenu)
				{
					subMenu.hide(disposeThis);
				}
				if(disposeThis)
				{
					dispose();
				}
			}
		}
		
		/**
		 *   设置触发者
		 * @param invoker 触发者（通常是一个button对象），menu会为invoker自动添加点击的监听函数。
		 * @param allowInvokerReclick 当重复点击触发者时，是否重新以单击点坐标放置菜单
		 * 
		 */
		public function setInvoker(invoker:InteractiveObject=null,allowInvokerReclick:Boolean=false):void
		{
			if(menuInvoker)menuInvoker.dispose();
			if(invoker)	this.menuInvoker=new MenuInvoker(invoker,this);
			this.allowInvokerReclick=allowInvokerReclick;
		}
		
		public function show():void
		{
			//检测invoker重复点击
			if(!allowInvokerReclick&&isShowing)return;
			if(!menuItemVos)return;
			removeAll();
			var items:Array=[];
			for (var i:int = 0; i < menuItemVos.length; i++) 
			{
				var item:LMenuItem=new LMenuItem(menuItemVos[i]);
				item.addEventListener(LEvent.MOUSE_OVER_MENU_ITEM,onMouseOverItem)
				item.setWH(isPrimary?UiConst.MENU_PRIMARY_WIDTH:UiConst.MENU_SUB_WIDTH,UiConst.MENU_ITEM_HEIGHT);
				items.push(item);
			}
			if(items.length)
			{
				appendAll.apply(null,items);
			}			
			LUIManager.uiContainer.addChild(this);
			pack();
		}
		
		protected function onMouseOverItem(event:LEvent):void
		{
			var item:LMenuItem=event.target as LMenuItem;
			if(item&&item.vo)
			{
				if(subMenu)subMenu.hide(true);
				if(item.hasSubMenu)
				{
					subMenu=new LMenu();
					subMenu.setMenuData(item.vo.subMenuItemVos,false,menuItemClickHandler);
					subMenu.popX=this.x+item.width-8;
					subMenu.popY=this.y+item.y;
					subMenu.show();
				}
			}
		}
		
		/**
		 *   创建一个菜单
		 * @param invoker 触发者（通常是一个button对象），menu会为invoker自动添加点击的监听函数。
		 *  @param menuItemVos 菜单数据
		 * @param isPrimary 是否为主菜单
		 * @param menuItemClickHandler 选中菜单项时的回调函数（参数:MenuItemVO）
		 * </br>eg. 
		 * </br>function xxx(vo:MenuItemVO):void
		 * </br>{
		 * </br>		trace(vo.text);
		 * </br>}
		 * 
		 */
		public static function createMenu(invoker:InteractiveObject, menuItemVos:Vector.<MenuItemVO>,isPrimary:Boolean=true,  menuItemClickHandler:Function=null):LMenu
		{
			var menu:LMenu=new LMenu();
			menu.setInvoker(invoker);
			menu.setMenuData(menuItemVos,isPrimary,menuItemClickHandler);
			return menu;
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=MenuLayout;
		}
		
		/**
		 * 获取选中的菜单项 
		 * @return 
		 * 
		 */		
		public function get selectedMenuItem():LMenuItem
		{
			return selectedItem as LMenuItem;
		}
		
		/**
		 *设置菜单数据 
		 * @param menuItemVos 菜单数据
		 * @param isPrimary 是否为主菜单
		 * @param menuItemClickHandler 选中菜单项时的回调函数（参数:MenuItemVO）
		 * </br>eg. 
		 * </br>function xxx(vo:MenuItemVO):void
		 * </br>{
		 * </br>		trace(vo.text);
		 * </br>}
		 */
		public function setMenuData(menuItemVos:Vector.<MenuItemVO>, isPrimary:Boolean, menuItemClickHandler:Function=null):void
		{
			_isPrimary=isPrimary;
			this.menuItemVos=menuItemVos;
			this.menuItemClickHandler = menuItemClickHandler;
			this.onSelectedChange(onMenuItemClick);
		}
		
		private function onMenuItemClick():void
		{
			if(menuItemClickHandler != null)menuItemClickHandler(selectedMenuItem.vo);
		}
		
		override public function dispose():void
		{
			this.menuItemVos=null;
			if(menuInvoker)menuInvoker.dispose();
			this.menuInvoker=null;
			this.subMenu=null;
			super.dispose();
		}

	}
}
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;

import org.leui.components.LMenu;
import org.leui.core.IDispose;
import org.leui.events.LStageEvent;
import org.leui.utils.LUIManager;

class MenuInvoker implements IDispose
{
	private var invoker:InteractiveObject;
	private var menu:LMenu;
	public function MenuInvoker(invoker:InteractiveObject,menu:LMenu)
	{
		setInvoker(invoker,menu);
	}
	
	public function setInvoker(invoker:InteractiveObject,menu:LMenu):void
	{
		this.invoker=invoker;
		this.menu=menu;
		LUIManager.addGlobalEventListener(LStageEvent.STAGE_CLICK_EVENT,onStageClick);
	}
	
	private function onStageClick(evt:LStageEvent):void
	{
		if(invoker==evt.clickTarget||((invoker is DisplayObjectContainer)&&(invoker as DisplayObjectContainer).contains(evt.clickTarget)))
		{
			menu.popX=LUIManager.stage.mouseX;
			menu.popY=LUIManager.stage.mouseY;
			menu.show();
		}
		else
		{
			menu.hide();
		}
	}
	
	public function dispose():void
	{
		if(invoker)
			LUIManager.removeGlobalEventListener(LStageEvent.STAGE_CLICK_EVENT,onStageClick);
		this.invoker=null;
		this.menu=null;
	}
}