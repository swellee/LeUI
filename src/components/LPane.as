package components
{
	import flash.display.DisplayObject;
	
	import core.IViewport;
	
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
			this.view.x=posX;
			this.view.y=posY;
		}
		
		public function get viewWidth():int
		{
			return view.width;
		}
		public function get viewHeight():int
		{
			return view.height;
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
			
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
			super.width=value;
		}
		override public function set height(value:Number):void
		{
			if(value==height)return;
			
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
			super.height=value;
		}
		
		override public function append(child:DisplayObject, layoutImmediately:Boolean=true):void
		{
			super.append(child,layoutImmediately);
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
		}
		override public function remove(child:DisplayObject, dispose:Boolean=true):DisplayObject
		{
			super.remove(child,dispose);
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
			return child;
		}
		///--------------------------------------------------
	}
}