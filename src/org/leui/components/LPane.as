package org.leui.components
{
	
	import org.leui.core.IViewport;
	
	/**
	 *  普通面板容器，实现了IViewport，可用于LScrollPane
	 *@author swellee
	 */
	public class LPane extends LContainer implements IViewport
	{
		/**
		 * 作为IViewport时，尺寸变化的侦听函数
		 */		
		protected var viewSizeListenFun:Function;
		/**
		 * 普通面板容器，实现了IViewport，可用于LScrollPane
		 */
		public function LPane()
		{
			super();
		}
		
		public function setViewPosition(posX:Number, posY:Number):void
		{
			this.container.x=posX;
			this.container.y=posY;
		}
		
		public function get viewWidth():int
		{
			return container.width;
		}
		public function get viewHeight():int
		{
			return container.height;
		}
		
		public function addViewSizeListener(fun:Function):void
		{
			this.viewSizeListenFun=fun;
		}
		
		public function removeViewSizeListener():void
		{
			this.viewSizeListenFun=null;
		}
		
		override protected function renderLayout():void
		{
			super.renderLayout();
			callViewListenFun();
		}
		private function callViewListenFun():void
		{
			if(viewHeight<=height)container.y=0;
			if(viewWidth<=width)container.x=0;
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
		}
		override public function dispose():void
		{
			removeViewSizeListener();
			super.dispose();
		}
	}
}