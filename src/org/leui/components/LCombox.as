package org.leui.components
{
	import flash.events.MouseEvent;
	
	import org.leui.events.LEvent;
	import org.leui.layouts.ComboxLayout;
	import org.leui.utils.LUIManager;
	import org.leui.utils.UiConst;
	import org.leui.vos.ChildStyleHashVO;
	import org.leui.vos.ComboxListVO;

	/**
	 *  下拉菜单框
	 *@author swellee
	 */
	public class LCombox extends LCombine
	{
		public var ele_text:LText;
		public var ele_btn:LToggleButton;
		public var ele_scrollPane:LScrollPane;
		private var itemList:LList;//菜单项的列表容器，会作为viewport放入到ele_scrollPane中
		
		
		/**
		 *  菜单列表数据 
		 */
		private var listdatas:Vector.<ComboxListVO>;
		/**
		 *菜单项选中时的回调函数 
		 */
		private var selectItemCallFun:Function;
		private var listDataInited:Boolean;
		private var listCellStyle:String;
		public function LCombox()
		{
			super();
		}
		override protected function initElements():void
		{
			ele_text=new LText("",false);
			ele_btn=new LToggleButton();
			ele_scrollPane=new LScrollPane(itemList=new LList());
			ele_text.setAlign(UiConst.TEXT_ALIGN_MIDDLE_CENTER,-UiConst.SCROLLPANE_BAR_INIT_SIZE);
			appendAll(ele_text,ele_btn);
		}
		override protected function initElementStyleHash():void
		{
			super.initElementStyleHash();
			elementStyleHash.push(new ChildStyleHashVO("ele_text"));
			elementStyleHash.push(new ChildStyleHashVO("ele_btn"));
			elementStyleHash.push(new ChildStyleHashVO("ele_scrollPane"));
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			ele_text.addEventListener(MouseEvent.ROLL_OUT,shareMouseEventHandler);
			ele_text.addEventListener(MouseEvent.ROLL_OVER,shareMouseEventHandler);
			ele_text.addEventListener(MouseEvent.MOUSE_DOWN,shareMouseEventHandler);
			ele_text.addEventListener(MouseEvent.MOUSE_UP,shareMouseEventHandler);
			ele_text.addEventListener(MouseEvent.CLICK,shareMouseEventHandler);
			ele_btn.addEventListener(MouseEvent.CLICK,onMouseClickHandler);
			itemList.addEventListener(LEvent.SELECTED_IN_LIST,onSelectInList);
		}
		override protected function removeEvents():void
		{
			super.removeEvents();
			ele_text.removeEventListener(MouseEvent.ROLL_OUT,shareMouseEventHandler);
			ele_text.removeEventListener(MouseEvent.ROLL_OVER,shareMouseEventHandler);
			ele_text.removeEventListener(MouseEvent.MOUSE_DOWN,shareMouseEventHandler);
			ele_text.removeEventListener(MouseEvent.MOUSE_UP,shareMouseEventHandler);
			ele_text.removeEventListener(MouseEvent.CLICK,shareMouseEventHandler);
			ele_btn.removeEventListener(MouseEvent.CLICK,onMouseClickHandler);
			itemList.removeEventListener(LEvent.SELECTED_IN_LIST,onSelectInList);
		}
		
		protected function shareMouseEventHandler(event:MouseEvent):void
		{
			ele_btn.dispatchEvent(event);
		}
		
		protected function onMouseClickHandler(event:MouseEvent):void
		{
			if(!listdatas)return;
			
			if(!listDataInited)
			{
				var items:Array=[];
				for (var i:int = 0; i < listdatas.length; i++) 
				{
					var vo:ComboxListVO=listdatas[i];
					var btn:LButton=new LButton();
					btn.text = vo.label;
					btn.data=vo.data;
					btn.style=listCellStyle;
					btn.setWH(width-UiConst.SCROLLPANE_BAR_INIT_SIZE*2,UiConst.MENU_ITEM_HEIGHT);
					items.push(btn);
				}
				if(items.length)
				{
					itemList.appendAll.apply(null,items);
				}
				listDataInited=true;
			}
			if(ele_btn.selected)
			{
				LUIManager.uiContainer.addChild(ele_scrollPane);
			}
			else
			{
				if(ele_scrollPane.parent)ele_scrollPane.parent.removeChild(ele_scrollPane);
			}
		}
		
		protected function onSelectInList(event:LEvent):void
		{
			
			if(itemList.selectedItem)
			{
				ele_text.text=LButton(itemList.selectedItem).text;
				if(null!=selectItemCallFun)
				selectItemCallFun(itemList.selectedItem.data);
				ele_btn.selected=false;
				onMouseClickHandler(null);
			}
		}
		
		public function setListData(listDatas:Vector.<ComboxListVO>,selectItemCall:Function=null,listCellStyle:String="LMenuItem"):void
		{
			this.listdatas=listDatas;
			this.selectItemCallFun=selectItemCall;
			this.listCellStyle=listCellStyle;
			if(listdatas)
			{
				ele_text.text=listdatas[0].label;
			}
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=ComboxLayout;
		}
		
		override public function dispose():void
		{
			listdatas=null;
			selectItemCallFun=null;
			if(ele_scrollPane)
			{
				if(ele_scrollPane.parent)ele_scrollPane.parent.removeChild(ele_scrollPane);
				ele_scrollPane.dispose();
				ele_scrollPane=null;
			}
			super.dispose();
		}
	}
}