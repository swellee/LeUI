package org.leui.components
{
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.leui.core.IMatirxContainer;
	import org.leui.layouts.BoxLayout;
	import org.leui.utils.UiConst;
	import org.leui.vos.ChildStyleHashVO;

	/**
	 *@author swellee
	 *2013-5-9
	 *圆点按钮，由一个LToggleButton和一个LText组合而成。
	 * </br>注意：圆点的宽高默认使用UiConst.ICON_DEFAULT_SIZE，并在垂直方向居中；
	 * </br>文本的宽高默认为UiConst.TEXT_DEFAULT_WIDTH,UiConst.TEXT_DEFAULT_HEIGHT；
	 */
	public class LRadioButton extends LCombine implements IMatirxContainer
	{
		public var ele_btn:LToggleButton;
		public var ele_text:LText;
		private var _hGap:int;
		
		public function LRadioButton(text:String=null,margin:int=4)
		{
			super();
			this.hGap=margin;
			if(text)
			{
				ele_text.text=text;
			}
		}
		override protected function initElements():void
		{
			super.initElements();
			ele_btn=new LToggleButton();
			ele_btn.setWH(UiConst.ICON_DEFAULT_SIZE,UiConst.ICON_DEFAULT_SIZE);
			ele_btn.canScaleX=false;
			ele_btn.canScaleY=false;
			ele_text=new LText("",false);
			ele_text.setAlign(UiConst.TEXT_ALIGN_MIDDLE_CENTER);
			appendAll(ele_btn,ele_text);
		}
		
		override protected function initElementStyleHash():void
		{
			super.initElementStyleHash();
			_elementStyleHash.push(new ChildStyleHashVO("ele_btn"));
			_elementStyleHash.push(new ChildStyleHashVO("ele_text"));
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			ele_text.addEventListener(MouseEvent.ROLL_OUT,shareMouseEventHandler);
			ele_text.addEventListener(MouseEvent.ROLL_OVER,shareMouseEventHandler);
			ele_text.addEventListener(MouseEvent.MOUSE_DOWN,shareMouseEventHandler);
			ele_text.addEventListener(MouseEvent.MOUSE_UP,shareMouseEventHandler);
			ele_text.addEventListener(MouseEvent.CLICK,shareMouseEventHandler);
		}
		override protected function removeEvents():void
		{
			super.removeEvents();
			ele_text.removeEventListener(MouseEvent.ROLL_OUT,shareMouseEventHandler);
			ele_text.removeEventListener(MouseEvent.ROLL_OVER,shareMouseEventHandler);
			ele_text.removeEventListener(MouseEvent.MOUSE_DOWN,shareMouseEventHandler);
			ele_text.removeEventListener(MouseEvent.MOUSE_UP,shareMouseEventHandler);
			ele_text.removeEventListener(MouseEvent.CLICK,shareMouseEventHandler);
		}
		
		protected function shareMouseEventHandler(event:MouseEvent):void
		{
			ele_btn.dispatchEvent(event);
		}
		/**
		 *设置按钮文本 
		 * @param text
		 * 
		 */		
		public function setText(text:String):void
		{
			ele_text.text=text;
		}
		public function get textField():TextField
		{
			if(ele_text)
				return ele_text.textField;
			return null;
		}
		override public function getLayoutManager():Class
		{
			return _layoutManager||=BoxLayout;
		}
		public function set direction(val:int):void
		{
		}
		public function get direction():int
		{
			return UiConst.HORIZONTAL;
		}
		public function set hGap(val:int):void
		{
			_hGap=val;
		}
		public	function get hGap():int
		{
			return _hGap;
		}
		public	function set vGap(val:int):void
		{
		}
		public	function get vGap():int
		{
			return 0;
		}
	}
}