package org.leui.components
{
	
	import flash.display.DisplayObject;
	
	import org.leui.core.IViewport;
	
	/**
	 *@author swellee
	 *2013-8-5
	 *普通面板容器，实现了IViewport，可用于LScrollPane
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
		override public function set width(value:Number):void
		{
			if(value==width)return;
			
			super.width=value;
			callViewListenFun();
		}
		override public function set height(value:Number):void
		{
			if(value==height)return;
			
			super.height=value;
			callViewListenFun();
		}
		
		override public function append(child:DisplayObject, layoutImmediately:Boolean=true):void
		{
			super.append(child,layoutImmediately);
			callViewListenFun();
		}
		override public function remove(child:DisplayObject, dispose:Boolean=true):DisplayObject
		{
			super.remove(child,dispose);
			callViewListenFun();
			return child;
		}
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject=super.removeChildAt(index);
			callViewListenFun();
			return child;
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