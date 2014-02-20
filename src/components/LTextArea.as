package components
{
	import flash.events.Event;
	
	import core.IViewport;
	
	/**
	 *@author swellee
	 *2013-8-18
	 *
	 */
	public class LTextArea extends LText implements IViewport
	{
		/**
		 * 作为IViewport时，尺寸变化的侦听函数
		 */		
		protected var viewSizeListenFun:Function;
		/**
		 *可显示的行数 
		 */
		private var maxTextlines:int;
		/**
		 *行高 
		 */
		private var lineHeight:Number;
		
		public function LTextArea(text:String="", editable:Boolean=true)
		{
			super(text, editable);
			textField.mouseWheelEnabled=false;
			textField.wordWrap=true;
			textField.multiline=true;
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			textField.addEventListener(Event.CHANGE,textChangeHandler);
		}
		override protected function removeEvents():void
		{
			super.removeEvents();
			textField.removeEventListener(Event.CHANGE,textChangeHandler);
		}
		protected function textChangeHandler(event:Event):void
		{
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
		}
		override public function set text(value:String):void
		{
			var oldLines:int=textField.numLines;
			super.text=value;
			if(textField.numLines!=oldLines)
			{
				viewSizeListenFun.call(null);
			}
		}
		public function setViewPosition(posX:Number, posY:Number):void
		{
			if(posY<0)//向下滚动
			{
				textField.scrollV=textField.getLineIndexAtPoint(10,3)+maxTextlines+1;
			}
			else
			{
				textField.scrollV=textField.getLineIndexAtPoint(10,3)-maxTextlines;
			}
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
			updateMaxTextLines();
		}
		/**
		 *根据最新高度，更新该高度所能显示的最大文字行数 
		 * 
		 */		
		private function updateMaxTextLines():void
		{
			lineHeight=textField.getLineMetrics(0).height;
			maxTextlines=(height-4)/lineHeight;
		}
		public function get viewWidth():int
		{
			return width;
		}
		public function get viewHeight():int
		{
			return textField.textHeight+4;
		}
	}
}