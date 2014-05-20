package org.leui.components
{
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import org.leui.core.ILayoutElement;
	import org.leui.events.LEvent;
	import org.leui.layouts.ListLayout;
	import org.leui.utils.LUIManager;
	import org.leui.utils.LeSpace;
	import org.leui.utils.UiConst;

	use namespace LeSpace;
	/**
	 *@author swellee
	 *2013-7-10
	 *列表容器
	 */
	public class LList extends LBox
	{
		
		protected var _selectedItem:LComponent;
		/**
		 *列表容器 
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
			var item:LComponent=LUIManager.findChildByProperty(container,{isListCell:true},event.target as DisplayObject);
			if(item)	selectedItem=item;
		}
		
		public function get selectedItem():LComponent
		{
			return _selectedItem;
		}
		public function set selectedItem(item:LComponent):void
		{
			if(!container.contains(item))
				return;
			if(_selectedItem==item)return;
			_selectedItem=item;
			dispatchEvent(new LEvent(LEvent.SELECTED_IN_LIST));
		}
		
		/**
		 *根据列表中子项的属性名-属性值 查找子项 
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
			super.dispose();
		}

	}
}