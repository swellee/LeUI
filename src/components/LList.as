package components
{
	import events.LEvent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import layouts.ListLayout;
	
	import utils.LUIManager;
	import utils.LeSpace;
	import utils.UiConst;

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
		 * @param gap 间距  /像素
		 * @param vertical 是否为竖向滚动条，默认为true
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

	}
}