package org.leui.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.leui.errors.LOverrideError;
	import org.leui.events.LStepperEvent;
	import org.leui.utils.UiConst;
	import org.leui.vos.ChildStyleHashVO;

	/**
	 *   数字步进器基类（不允许直接实例化，请使用子类LStepperH和LStepperV），由一个LText、两个LButton组合而成
	 *@author swellee
	 */
	public class Stepper extends LCombine
	{
		/**数字文本框*/
		public var ele_text:LText;
		/**增量按钮*/
		public var ele_increase_btn:LButton;
		/**减量按钮*/
		public var ele_decrease_btn:LButton;
		private var _curValue:int;
		private var _maxValue:int=int.MAX_VALUE;
		private var _minValue:int=0;
		private var _eleBtnSize:int;
		
		/**
		 *  数字步进组件 基类（不允许直接实例化）
		 */
		public function Stepper(eleBtnSize:int)
		{
			super();
			this._eleBtnSize=eleBtnSize;
		}

		/**
		 * 步进按钮的最大尺寸
		 */
		public function get eleBtnSize():int
		{
			return _eleBtnSize;
		}

		/**
		 * @private
		 */
		public function set eleBtnSize(value:int):void
		{
			if(value == _eleBtnSize)return;
			_eleBtnSize = value;
			updateLayout();
		}

		/**
		 *最大值 ，默认为int.MAX_VALUE
		 * 
		 */
		public function get maxValue():int
		{
			return _maxValue;
		}

		public function set maxValue(value:int):void
		{
			_maxValue = value;
		}

		/**
		 * 最小值，默认为0
		 * 
		 */
		public function get minValue():int
		{
			return _minValue;
		}

		public function set minValue(value:int):void
		{
			_minValue = value;
		}

		public function get curValue():int
		{
			return _curValue;
		}

		public function set curValue(value:int):void
		{
			value=Math.max(_minValue,value);
			value=Math.min(_maxValue,value);
			_curValue = value;
			ele_text.text=_curValue.toString();
			dispatchEvent(new LStepperEvent(LStepperEvent.VALUE_CHANGED));
		}

		override protected function initElements():void
		{
			super.initElements();
			ele_text=new LText();
			ele_increase_btn=new LButton();
			ele_decrease_btn=new LButton();
			ele_text.setAlign(UiConst.TEXT_ALIGN_MIDDLE_CENTER);
			ele_text.text=_curValue.toString();
			appendAll(ele_text,ele_increase_btn,ele_decrease_btn);
		}
		override protected function initElementStyleHash():void
		{
			super.initElementStyleHash();
			_elementStyleHash.push(new ChildStyleHashVO("ele_text"));
			_elementStyleHash.push(new ChildStyleHashVO("ele_increase_btn"));
			_elementStyleHash.push(new ChildStyleHashVO("ele_decrease_btn"));
		}
		override protected function addEvents():void
		{
			super.addEvents();
			ele_text.addEventListener(Event.CHANGE,textChangeHandler);
			ele_increase_btn.addEventListener(MouseEvent.CLICK,upBtnClickHandler);
			ele_decrease_btn.addEventListener(MouseEvent.CLICK,downBtnClickHandler);
		}
		
		protected function textChangeHandler(event:Event):void
		{
			curValue=int(ele_text.text);
		}
		
		protected function upBtnClickHandler(event:MouseEvent):void
		{
			curValue++;
		}
		
		protected function downBtnClickHandler(event:MouseEvent):void
		{
			curValue--;
		}
		
		override public function getLayoutManager():Class
		{
			//基类不可使用，必须实例化子类
			throw new LOverrideError("must use subClass instand of this base class");
		}
	}
}