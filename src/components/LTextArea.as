package components
{
	import core.IViewport;
	
	import flash.events.Event;
	
	import utils.UiConst;
	
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
		private var oldNumLines:int;
		
		public function LTextArea(text:String="", editable:Boolean=true)
		{
			super(text, editable);
			setAlign(UiConst.TEXT_ALIGN_NONE);
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
			if(textField.height<=height)
			{
				textField.y=0;
			}
			if(textField.numLines!=oldNumLines)
			{
				textField.height=textField.textHeight+textFrameSpace;
				oldNumLines=textField.numLines;
				viewSizeListenFun.call(null);
			}
		}
		override public function set text(value:String):void
		{
			oldNumLines=textField.numLines;
			super.text=value;
			textChangeHandler(null);
		}
		public function setViewPosition(posX:Number, posY:Number):void
		{
			textField.x=posX;
			textField.y=posY;
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
			textField.width=width;
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
		}
		override public function set height(value:Number):void
		{
			if(value==height)return;
			
			super.height=value;
			textField.height=height;
			if(viewSizeListenFun!=null)
			{
				viewSizeListenFun.call(null);
			}
		}
		
		public function get viewWidth():int
		{
			return textField.width;
		}
		public function get viewHeight():int
		{
			return textField.height;
		}
	}
}