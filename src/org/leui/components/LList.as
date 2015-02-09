package org.leui.components
{
	
	import org.leui.core.ILayoutElement;
	import org.leui.events.MouseEvent;
	import org.leui.layouts.ListLayout;
	import org.leui.utils.LUIManager;
	import org.leui.utils.LeSpace;
	import org.leui.utils.UiConst;
	
	import starling.display.DisplayObject;

	use namespace LeSpace;
	/**
	 *  列表容器 子元素布局方向可选择横向或竖向,  同一时间，只能选中单一子元素
	 *@author swellee
	 */
	public class LList extends LBox
	{
		
		protected var _selectedItem:LComponent;
		protected var itemClickHandler:Function;

		/**
		 * 列表容器 
		 * @param hGap 横向间距  /像素
		 * @param vGap 竖向间距  /像素
		 * @param vertical 是否为竖向列表，默认为true
		 * 
		 */
		public function LList(hGap:int=0,vGap:int=0,vertical:Boolean=true)
		{
			super(hGap,vGap);
			container.isListContainer=true;
			this._direction=vertical?UiConst.VERTICAL:UiConst.HORIZONTAL;
		}
		override protected function addEvents():void
		{
			super.addEvents();
			container.addEventListener(MouseEvent.CLICK,mouseClickHandler);
		}
		override protected function removeEvents():void
		{
			super.removeEvents();
			container.removeEventListener(MouseEvent.CLICK,mouseClickHandler);
		}
		override public function getLayoutManager():Class
		{
			return _layoutManager||=ListLayout;
		}

		protected function mouseClickHandler(event:MouseEvent):void
		{
			var item:LComponent = LUIManager.findChildByProperty(container,{isListCell:true},event.target as DisplayObject);
			if(item)	selectedItem=item;
		}
		
		/**
		 *   获取当前选中项 
		 * 
		 */
		public function get selectedItem():LComponent
		{
			return _selectedItem;
		}
		/**
		 *   设置当前选中项 
		 * @param item
		 * 
		 */
		public function set selectedItem(item:LComponent):void
		{
			if(!container.contains(item))
				return;
			if(_selectedItem==item)return;
			_selectedItem=item;
			if(itemClickHandler != null)itemClickHandler();
		}
		
		/**
		 *  设置 选中子项时的回调函数（无参数） 
		 * @param fun 无参数的函数,可在此函数中通过list的selectedItem获取被点选的项
		 * </br>eg. 
		 * </br> list.onSelectedChange(xxx);
		 * </br>function xxx():void
		 * </br>{
		 * </br>		trace(list.selectedItem.data);
		 * </br>}
		 * 
		 */
		public function onSelectedChange(fun:Function):void
		{
			this.itemClickHandler = fun;
		}
		
		/**
		 *  根据列表中子项的属性名-属性值 查找子项 
		 * @param propertyName 属性名
		 * @param propertyValue 属性值
		 * @return 按子项被添加的顺序返回第一个匹配的项
		 * 
		 */
		public function getItemByProperty(propertyName:String,propertyValue:*):LComponent
		{
			for each (var ele:ILayoutElement in _layoutElements) 
			{
				var item:LComponent=ele as LComponent;
				if(!item)continue;
				if(item.hasOwnProperty(propertyName)&&item[propertyName]==propertyValue)
				{
					return item;
				}
			}
			return null;
		}
		
		override public function dispose():void
		{
			_selectedItem=null;
			itemClickHandler = null;
			super.dispose();
		}

	}
}