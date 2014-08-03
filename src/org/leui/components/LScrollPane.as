package org.leui.components
{
	
	import flash.display.DisplayObject;
	
	import org.leui.core.IViewport;
	import org.leui.events.LScrollBarEvent;
	import org.leui.layouts.ScrollPaneLayout;
	import org.leui.utils.LTrace;
	import org.leui.utils.UiConst;
	import org.leui.vos.ChildStyleHashVO;

	[Event(name="scrollbar_value_change", type="org.leui.events.LScrollBarEvent")]
	/**
	 *   滚动面板
	 *@author swellee
	 */
	public class LScrollPane extends LCombine
	{
		///子组件
		public var ele_v_scroll_bar:LScrollBar;
		public var ele_h_scroll_bar:LScrollBar;
		public var ele_view_port:IViewport;
		/**
		 *纵向滚动条显示规则 默认值为UiConst.SCROLL_BAR_POLICY_AUTO
		 */
		public var vsbPolicy:int;
		/**
		 *横向滚动条显示规则 默认值为UiConst.SCROLL_BAR_POLICY_AUTO
		 */
		public var hsbPolicy:int;
		/**
		 *当组件初始化完成时，使用自身的容器属性时给予警告
		 */
		private var transferContainer:Boolean;
		private var needRenderScrollBar:Boolean;
		/**
		 *  滚动面板 
		 * @param viewPort 视口对象
		 * @param hsbPolicy 横向滚动条显示规则，默认为UiConst.SCROLL_BAR_POLICY_AUTO
		 * @param vsbPolicy 纵向滚动条显示规则，默认为UiConst.SCROLL_BAR_POLICY_AUTO
		 * 
		 */
		public function LScrollPane(viewPort:IViewport=null,hsbPolicy:int=0,vsbPolicy:int=0)
		{
			this.ele_view_port=viewPort;
			this.hsbPolicy=hsbPolicy;
			this.vsbPolicy=vsbPolicy;
			super();
		}
		
		override protected function initElements():void
		{
			if(!ele_view_port)
				ele_view_port=new LPane();
			ele_view_port.setXY(0,0);
			ele_v_scroll_bar=new LScrollBar();
			ele_h_scroll_bar=new LScrollBar(false);
			ele_v_scroll_bar.visible=ele_h_scroll_bar.visible=false;
			appendAll(ele_view_port,ele_h_scroll_bar,ele_v_scroll_bar);
			transferContainer=true;
		}
		override protected function initElementStyleHash():void
		{
			super.initElementStyleHash();
			_elementStyleHash.push(new ChildStyleHashVO("ele_v_scroll_bar"));
			_elementStyleHash.push(new ChildStyleHashVO("ele_h_scroll_bar"));
			_elementStyleHash.push(new ChildStyleHashVO("ele_view_port"));
		}
		override protected function addEvents():void
		{
			super.addEvents();
			ele_view_port.addViewSizeListener(listenViewSizeChange);
			ele_h_scroll_bar.addEventListener(LScrollBarEvent.VALUE_CHANGE,onScrollbarValueChange);
			ele_v_scroll_bar.addEventListener(LScrollBarEvent.VALUE_CHANGE,onScrollbarValueChange);
		}
		override protected function removeEvents():void
		{
			super.removeEvents();
			ele_view_port.removeViewSizeListener();
			ele_h_scroll_bar.removeEventListener(LScrollBarEvent.VALUE_CHANGE,onScrollbarValueChange);
			ele_v_scroll_bar.removeEventListener(LScrollBarEvent.VALUE_CHANGE,onScrollbarValueChange);
			
		}
		private function listenViewSizeChange():void
		{
			needRenderScrollBar=true;
			render();
			onScrollbarValueChange(null);
		}
		protected function onScrollbarValueChange(event:LScrollBarEvent):void
		{
			var scrBarSize:int=UiConst.SCROLLPANE_BAR_INIT_SIZE;
			var h:Number=ele_h_scroll_bar.value*(ele_view_port.viewWidth-width+scrBarSize)/100;
			var v:Number=ele_v_scroll_bar.value*(ele_view_port.viewHeight-height+scrBarSize)/100;
			ele_view_port.setViewPosition(-h,-v);
		}
		//重写添加子对象的函数，将容器属性转嫁给视口对象
		override public function append(child:DisplayObject, layoutImmediately:Boolean=true):void
		{
			super.append(child,layoutImmediately);
			if(transferContainer)
			{
				LTrace.warnning("promote not to call 'append/appendAll/addChild...' function of a LScrollPane," +
					"displayObject won't be added, cause it's not a really container");
			}
		}
		override protected function render():void
		{
			super.render();
			renderScrollBar();
		}
		/**重绘滚动条*/
		private function renderScrollBar():void
		{
			if(needRenderScrollBar)
			{
				needRenderScrollBar=false;
				updateScrollBar();
			}
		}
		/**
		 *  视口 
		 * @return 
		 * 
		 */
		public function getViewport():IViewport
		{
			return ele_view_port;
		}
		
		override public function get contentPane():LContainer
		{
			return ele_view_port as LContainer;
		}
		
		/**
		 *根据视口窗口的显示区域及实际尺寸，更新滚动条的显示 
		 * 
		 */		
		private function updateScrollBar():void
		{
			var lengthPercent:int;
			if(hsbPolicy!=UiConst.SCROLLPANE_BAR_POLICY_NEVER)//是否显示横向滚动条
			{
				var contentWidth:int=ele_view_port.viewWidth;
				var viewWidth:int=width-UiConst.SCROLLPANE_BAR_INIT_SIZE;
				if(contentWidth>viewWidth)
				{
					lengthPercent=Number(viewWidth/contentWidth)*100;
					ele_h_scroll_bar.visible=true;
					ele_h_scroll_bar.sliderLength=lengthPercent;
				}
				else
				{
					ele_h_scroll_bar.visible=false;
					ele_h_scroll_bar.value=0;
				}
			}
			if(vsbPolicy!=UiConst.SCROLLPANE_BAR_POLICY_NEVER)//竖向滚动条
			{
				var contentHeight:int=ele_view_port.viewHeight;
				var viewHeight:int=height-UiConst.SCROLLPANE_BAR_INIT_SIZE;
				if(contentHeight>viewHeight)
				{
					lengthPercent=Number(viewHeight/contentHeight)*100;
					ele_v_scroll_bar.visible=true;
					ele_v_scroll_bar.sliderLength=lengthPercent;
				}
				else
				{
					ele_v_scroll_bar.visible=false;
					ele_v_scroll_bar.value=0;
				}
			}
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=ScrollPaneLayout;
		}
	}
}