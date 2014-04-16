package components
{
	import events.LEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	import utils.LGeom;
	import utils.UiConst;
	import vos.MenuItemVO;

	/**
	 *@author swellee
	 *2014-3-17
	 *
	 */
	public class LMenuItem extends LButton
	{
		private var itemIcon:DisplayObject;
		private var _vo:MenuItemVO;
		private var itemClickHandler:Function;
		public function LMenuItem(menuItemVo:MenuItemVO,itemClickHandler:Function=null)
		{
			super(menuItemVo.text);
			this._vo=menuItemVo;
			this.style=menuItemVo.style;
			this.data=menuItemVo.data;
			this.itemClickHandler=itemClickHandler;
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			addEventListener(MouseEvent.CLICK,checkMouseClick);
		}
		override protected function removeEvents():void
		{
			super.removeEvents();
			removeEventListener(MouseEvent.CLICK,checkMouseClick);
		}
		
		/**
		 *菜单项VO 
		 * @return 
		 * 
		 */
		public function get vo():MenuItemVO
		{
			return _vo;
		}
		
		/**
		 *是否链接有子级菜单 
		 */
		public function get hasSubMenu():Boolean
		{
			return _vo&&_vo.subMenuItemVos&&_vo.subMenuItemVos.length>0;
		}
		
		override protected function onMouseOverHandler(event:MouseEvent):void
		{
			super.onMouseOverHandler(event);
			this.dispatchEvent(new LEvent(LEvent.MOUSE_OVER_MENU_ITEM));
		}
		
		/**
		 *设置图标 
		 * @param icon
		 * @param offX
		 * 
		 */
		public function setIcon():void
		{
			var icon:DisplayObject=_vo.icon;
			var offX:int=_vo.iconOffX;
			if(icon&&itemIcon!=icon)
			{
				if(itemIcon&&itemIcon.parent)
				{
					itemIcon.parent.removeChild(itemIcon);
				}
				itemIcon=icon;
				itemIcon.x=offX;
				addChild(itemIcon);
			}
			//submenu tag
			if(hasSubMenu)
			{
				var tag:Shape=new Shape();
				var g:Graphics=tag.graphics;
				g.clear();
				g.lineStyle(2,UiConst.MENU_ITEM_SUB_TAG_COLOR);
				g.moveTo(width-15,6);
				g.lineTo(width-10,height/2);
				g.lineTo(width-15,height-6);
				g.endFill();
				addChild(tag);
			}
		}
		
		protected function checkMouseClick(event:MouseEvent):void
		{
			//有子级菜单时，屏蔽点击
			if(hasSubMenu)event.stopImmediatePropagation();
		}
		
		override public function setWH(width:int=-1, height:int=-1):void
		{
			super.setWH(width,height);
			setIcon();
		}

		override public function set data(val:*):void
		{
			super.data=val;
			if(_vo)_vo.data=val;
		}
		override protected function render():void
		{
			super.render();
			if(itemIcon)	LGeom.centerInCoordY(itemIcon,this);
		}
		
		override public function dispose():void
		{
			_vo=null;
			itemIcon=null;
			itemClickHandler=null;
			super.dispose();
		}
	}
}