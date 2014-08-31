package org.leui.components
{
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.leui.core.IPopup;
	import org.leui.layouts.WindowLayout;
	import org.leui.utils.LUIManager;
	import org.leui.utils.LeSpace;
	import org.leui.utils.UiConst;
	import org.leui.vos.ChildStyleHashVO;

	use namespace LeSpace;
	/**
	 *  视窗 由子元素：标题、关闭按钮、内容面板 组合而成；
	 * 实现了IPopup接口,显示视窗请调用show(); 
	 * 向视窗中添加内容时，使用addContent()方法；此方法会将参数作为显示对象添加到内容面板中。
	 *@author swellee
	 */
	public class LWindow extends LCombine implements IPopup
	{
		/**
		 *标题 
		 */
		public var ele_title_txt:LText;
		/**
		 *内容面板 
		 */
		public var ele_content_pane:LPane;
		/**
		 *关闭按键 
		 */
		public var ele_close_btn:LButton;
		/**
		 *点击关闭按键时，是否在隐藏视窗时自动销毁 
		 */
		private var autoDisposeOnClose:Boolean;
		/**
		 *视窗是否可拖动 默认为true
		 */
		private var canDrag:Boolean=true;
		
		/**
		 *视窗   
		 * @param title 标题文本
		 * @param autoDisposeOnClose 点击关闭按键时，是否在隐藏视窗时自动销毁 
		 * @param canDrag 视窗是否可拖动
		 * 
		 */
		public function LWindow(title:String=null,autoDisposeOnClose:Boolean=false,canDrag:Boolean=true)
		{
			super();
			this.autoDisposeOnClose=autoDisposeOnClose;
			this.canDrag=canDrag;
			if(title)setTitle(title);
		}
		
		override protected function initElements():void
		{
			ele_title_txt=new LText("",false);
			ele_content_pane=new LPane();
			ele_close_btn=new LButton();
			ele_title_txt.setAlign(UiConst.TEXT_ALIGN_MIDDLE_CENTER);
			
			appendAll(ele_content_pane,ele_title_txt,ele_close_btn);
		}
		
		override protected function initElementStyleHash():void
		{
			super.initElementStyleHash();
			elementStyleHash.push(new ChildStyleHashVO("ele_title_txt"));
			elementStyleHash.push(new ChildStyleHashVO("ele_content_pane"));
			elementStyleHash.push(new ChildStyleHashVO("ele_close_btn"));
		}
		override protected function addEvents():void
		{
			super.addEvents();
			ele_close_btn.addEventListener(MouseEvent.CLICK,onCloseHandler);
			if(canDrag)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN,dragStart,true,0,true);
				this.addEventListener(MouseEvent.MOUSE_UP,dragEnd,true,0,true);
			}
		}
		
		override protected function removeEvents():void
		{
			super.removeEvents();
			ele_close_btn.removeEventListener(MouseEvent.CLICK,onCloseHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,dragStart);
			this.removeEventListener(MouseEvent.MOUSE_UP,dragEnd);
		}
		private function dragEnd(event:MouseEvent):void
		{
			stopDrag();
		}
		
		private function dragStart(event:MouseEvent):void
		{
			//拖动时，限定鼠标按下的位置在标题条范围内
			if(this.mouseX<width-UiConst.WINDOW_BUTTON_WIDTH-20&&
				this.mouseY<UiConst.WINDOW_BORDER_SIZE+UiConst.WINDOW_BUTTON_HEIGHT)
			{
				startDrag(false,new Rectangle(0,0,stage.stageWidth-width,stage.stageHeight-height));
			}
		}
		protected function onCloseHandler(event:MouseEvent):void
		{
			hide(autoDisposeOnClose);
		}
		/**
		 *  设置标题 
		 * @param title
		 * 
		 */
		public function setTitle(title:String):void
		{
			if(title) ele_title_txt.text=title;
		}
		
		override public function get contentPane():LContainer
		{
			return ele_content_pane;
		}
		
		/**
		 *  向视窗的内容面板中添加子显示对象.
		 * 视窗的内容面板是一个LPane对象，默认布局管理器为BasicLayout(实际上什么也不做) 
		 * @see LPane
		 * @see layouts.BasicLayout
		 * @param childs 要添加的显示对象
		 * 
		 */
		public function addContent(...childs):void
		{
			ele_content_pane.appendAll.apply(null,childs);
		}
		public function show():void
		{
			if(isShowing)return;
			
			LUIManager.uiContainer.addChild(this);
		}
		
		public function hide(disposeThis:Boolean=false):void
		{
			if(parent)
			{
				parent.removeChild(this);
			}
			if(disposeThis)
			{
				dispose();
			}
		}
		
		public function get isShowing():Boolean
		{
			return null!=parent;
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=WindowLayout;
		}
	}
}