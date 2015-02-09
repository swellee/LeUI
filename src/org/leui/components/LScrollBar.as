package org.leui.components
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import org.leui.events.LScrollBarEvent;
	import org.leui.events.MouseEvent;
	import org.leui.layouts.ScrollbarLayout;
	import org.leui.utils.LUIManager;
	import org.leui.utils.UiConst;
	import org.leui.vos.ChildStyleHashVO;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;


	/**
	 *   滚动条
	 *@author swellee
	 */
	public class LScrollBar extends LCombine
	{
		/**背景*/
		public var ele_bg:LComponent;
		/**滑块*/
		public var ele_slider:LButton;
		/**增量按钮*/
		public var ele_increase_btn:LButton;
		/**减量按钮*/
		public var ele_decrease_btn:LButton;
		
		//值
		private var _value:int = 0 ;
		private var _valueStep:int = UiConst.SCROLLBAR_STEP_VALUE;
		/**滚动条的满值*/
		private var valueCeiling:int = UiConst.SCROLLBAR_TOP_VALUE;
		
		/**
		 *记录滑块长度（占移动范围的百分比） 
		 */
		private var _sliderLength:int=UiConst.SCROLLBAR_SLIDER_INIT_VALUE_SIZE;
		/**
		 *目标值 
		 */
		private var targetValue:Number;
		/**
		 * 
		 */		
		private var msValueStep:Number;
		private var sliderMsOff:int;
		private var sliderMoveRange:Number;
		private var _isVertical:Boolean;
		private var eleMsDownStamp:int;
		private var msDownCacheTime:int=400;
		
		/**
		 *  滚动条 
		 * @param vertical 是否为竖向滚动条，默认为true
		 * 
		 */
		public function LScrollBar(vertical:Boolean=true)
		{
			super();
			this._isVertical=vertical;
		}
		override protected function initElementStyleHash():void
		{
			super.initElementStyleHash();
			_elementStyleHash.push(new ChildStyleHashVO("ele_bg"));
			_elementStyleHash.push(new ChildStyleHashVO("ele_slider"));
			_elementStyleHash.push(new ChildStyleHashVO("ele_decrease_btn"));
			_elementStyleHash.push(new ChildStyleHashVO("ele_increase_btn"));
		}
		override protected function initElements():void
		{
			ele_bg=new LComponent();
			ele_decrease_btn=new LButton();
			ele_increase_btn=new LButton();
			ele_slider=new LButton();
			ele_bg.touchGroup=true;
			ele_decrease_btn.touchGroup=true;
			ele_increase_btn.touchGroup=true;
			ele_slider.touchGroup=true;
			//ScrollbarLayout将以下面的顺序定位各功能组件：背景条>减量按键>滑块>增量按键
			appendAll(ele_bg,ele_decrease_btn,ele_slider,ele_increase_btn);
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=ScrollbarLayout;
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			ele_bg.addEventListener(MouseEvent.MOUSE_DOWN,onMsDownHandler);
			ele_decrease_btn.addEventListener(MouseEvent.MOUSE_DOWN,onMsDownHandler);
			ele_increase_btn.addEventListener(MouseEvent.MOUSE_DOWN,onMsDownHandler);
			ele_slider.addEventListener(MouseEvent.MOUSE_DOWN,onMsDownHandler);
			ele_decrease_btn.addEventListener(MouseEvent.CLICK,decreaseByClick);
			ele_increase_btn.addEventListener(MouseEvent.CLICK,increaseByClick);
		}
		
		
		override protected function removeEvents():void
		{
			super.removeEvents();
			ele_bg.removeEventListener(MouseEvent.MOUSE_DOWN,onMsDownHandler);
			ele_decrease_btn.removeEventListener(MouseEvent.MOUSE_DOWN,onMsDownHandler);
			ele_increase_btn.removeEventListener(MouseEvent.MOUSE_DOWN,onMsDownHandler);
			ele_slider.removeEventListener(MouseEvent.MOUSE_DOWN,onMsDownHandler);
			ele_decrease_btn.removeEventListener(MouseEvent.CLICK,decreaseByClick);
			ele_increase_btn.removeEventListener(MouseEvent.CLICK,increaseByClick);
			LUIManager.removeEnterFrameListener(onEnterFrameHandler);
		}
		
		override protected function onActive(event:Event):void
		{
			super.onActive(event);
			stage.addEventListener(TouchEvent.TOUCH,onMsUpHandler);
		}
		protected function onMsDownHandler(e:MouseEvent):void
		{
			
			var ele:LComponent=e.target as LComponent;
			eleMsDownStamp=getTimer();
			if(ele)
			{
				sliderMsOff=0;
				var stepMultiple:int=1;
				switch(ele)
				{
					case ele_bg:
						var msLoc:Number=isVertical?mouseX-width:mouseY-height;
						targetValue=msLoc*valueCeiling/sliderMoveRange;
						stepMultiple=2;
						eleMsDownStamp-=msDownCacheTime*.8;
						break;
					case ele_decrease_btn:
						targetValue=0;
						break;
					case ele_increase_btn:
						targetValue=valueCeiling;
						break;
					case ele_slider:
						eleMsDownStamp-=msDownCacheTime;
						sliderMsOff=isVertical?mouseY:mouseX;
						break;
				}
				msValueStep=valueStep*stepMultiple;
				if(targetValue<value)
				{
					msValueStep=-msValueStep;
				}
			}
			LUIManager.addEnterFrameListener(onEnterFrameHandler);
		}
		
		protected function onMsUpHandler(event:MouseEvent):void
		{
			LUIManager.removeEnterFrameListener(onEnterFrameHandler);
		}
		
		protected function decreaseByClick(event:MouseEvent):void
		{
			value-=valueStep;
		}
		
		protected function increaseByClick(event:MouseEvent):void
		{
			value+=valueStep;
		}
		
		//监测鼠标是否按下了功能按键，以便更新percent
		protected function onEnterFrameHandler(event:Event):void
		{
			if(!stage)return;
			if(getTimer()-eleMsDownStamp<msDownCacheTime)return;
			if(sliderMsOff!=0)
			{
				var msLoc:Number=isVertical?ele_bg.mouseY-width:ele_bg.mouseX-height;
				value=(msLoc-sliderMsOff)*valueCeiling/sliderMoveRange;
			}
			else if((msValueStep<0&&targetValue<value)||(msValueStep>0&&targetValue>value))
			{
				value+=msValueStep;
			}
		}		

		/**当前百分值（1－100）*/
		public function get value():int
		{
			return _value;
		}

		/**
		 * @private
		 */
		public function set value(val:int):void
		{
			val=Math.max(0,val);
			val=Math.min(valueCeiling,val);
			if(_value==val)return;
			_value = val;
			relocateSlider();
			//派发值更改事件
			dispatchEvent(new LScrollBarEvent(LScrollBarEvent.VALUE_CHANGE));
		}

		/**步进百分值（1－100）默认为UiConst.SCROLLBAR_STEP_VALUE*/
		public function get valueStep():int
		{
			return _valueStep;
		}

		/**
		 * @private
		 */
		public function set valueStep(val:int):void
		{
			val=Math.min(valueCeiling,val);
			val=Math.max(1,val);
			if(_valueStep==val)return;
			_valueStep = val;
		}

		/**
		 *根据value重置滑块位置
		 * 
		 */		
		private function relocateSlider():void
		{
			if(isVertical)
			{
				ele_slider.setXY(0,value/valueCeiling*sliderMoveRange+width);
			}
			else
			{
				ele_slider.setXY(value/valueCeiling*sliderMoveRange+height,0);
			}
		}		
		
		/**
		 * 
		 *   更新滑块尺寸及位置
		 */
		public function updateSlider():void
		{
			if(isVertical)
			{
				ele_slider.setWH(width,(height-width*2)*_sliderLength/100);
			}
			else
			{
				ele_slider.setWH((width-height*2)*_sliderLength/100,height);
			}
			updateSliderMoveRange();
			relocateSlider();
		}
		/**
		 *   设置滑块尺寸所占总轨道尺寸的百分比 ,若值小于等于0 ，则不作任何更改
		 * @param lengthPercent 百分比 值为1－100
		 * 
		 */
		public function set sliderLength(len:int):void
		{
			if(len<=0)
			{
				len=_sliderLength
			}
			len=Math.max(1,len);
			len=Math.min(len,100);
			if(len==_sliderLength)return;
			_sliderLength=len;
			updateSlider();
		}
		/**更新滑块移动范围*/
		private function updateSliderMoveRange():void
		{
			if(isVertical)
				sliderMoveRange= height-2*width-ele_slider.height;
			else
				sliderMoveRange= width-2*height-ele_slider.width;
		}

		/**是否为竖向滚动条*/
		public function get isVertical():Boolean
		{
			return _isVertical;
		}
		public function set isVertical(val:Boolean):void
		{
			_isVertical = val;
			updateLayout();
		}
		/**
		 *   重写默认样式名，改为根据朝向，竖向为LScrollBar，横向为LScrollBarH
		 * @return 
		 * 
		 */
		override public function getDefaultStyle():String
		{
			return isVertical?"LScrollBar":"LScrollBarH";
		}
	}
}