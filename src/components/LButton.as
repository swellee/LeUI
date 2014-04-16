package components
{
	import flash.events.MouseEvent;
	
	import utils.UiConst;
	
	import vos.ChildStyleHashVO;

	/**
	 *@author swellee
	 *2013-4-10
	 *按钮（带文本），继承自LMultiState-多状态组件，用来表现状态的组件是一个LText，因此配置状态样式需要是针对LText类型的样式
	 */
	public class LButton extends LMultiState
	{
		
		public static var BUTTON_STATE_MOUSE_OUT:String="button_state_mouse_out";
		public static var BUTTON_STATE_MOUSE_OVER:String="button_state_mouse_over";
		public static var BUTTON_STATE_MOUSE_DOWN:String="button_state_mouse_down";
		public static var BUTTON_STATE_SELECTED_MOUSE_OUT:String="button_state_selected_mouse_out";
		public static var BUTTON_STATE_SELECTED_MOUSE_OVER:String="button_state_selected_mouse_over";
		public static var BUTTON_STATE_SELECTED_MOUSE_DOWN:String="button_state_selected_mouse_down";
		
		public function LButton(text:String=null)
		{
			super();
			if(text)
			{
				setText(text);
			}
		}
		
		override protected function initStateUI():void
		{
			if(!stateUI)
			{
				stateUI=new LText("",false);
				stateUI.mouseChildren=false;
				LText(stateUI).setAlign(UiConst.TEXT_ALIGN_MIDDLE_CENTER,0,-2);
				addChild(stateUI);
			}
		}
			
		override protected function initStateStyleHash():void
		{
			super.initStateStyleHash();
			_stateStyleHash.push(new ChildStyleHashVO(BUTTON_STATE_MOUSE_OUT));
			_stateStyleHash.push(new ChildStyleHashVO(BUTTON_STATE_MOUSE_OVER));
			_stateStyleHash.push(new ChildStyleHashVO(BUTTON_STATE_MOUSE_DOWN));
			_stateStyleHash.push(new ChildStyleHashVO(BUTTON_STATE_SELECTED_MOUSE_OUT));
			_stateStyleHash.push(new ChildStyleHashVO(BUTTON_STATE_SELECTED_MOUSE_OVER));
			_stateStyleHash.push(new ChildStyleHashVO(BUTTON_STATE_SELECTED_MOUSE_DOWN));
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			addEventListener(MouseEvent.ROLL_OUT,onMouseOutHandler);
			addEventListener(MouseEvent.ROLL_OVER,onMouseOverHandler);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
		}
		
		override protected function removeEvents():void
		{
			super.removeEvents();
			removeEventListener(MouseEvent.ROLL_OUT,onMouseOutHandler);
			removeEventListener(MouseEvent.ROLL_OVER,onMouseOverHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			removeEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
		}
		protected function onMouseOutHandler(event:MouseEvent):void
		{
			if(selected)
				showState(BUTTON_STATE_SELECTED_MOUSE_OUT);
			else
				showState(BUTTON_STATE_MOUSE_OUT);
		}
		
		protected function onMouseOverHandler(event:MouseEvent):void
		{
			if(selected)
				showState(BUTTON_STATE_SELECTED_MOUSE_OVER)
			else
				showState(BUTTON_STATE_MOUSE_OVER);
		}
		
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			if(selected)
				showState(BUTTON_STATE_SELECTED_MOUSE_DOWN);
			else
				showState(BUTTON_STATE_MOUSE_DOWN);
		}
		
		protected function onMouseUpHandler(event:MouseEvent):void
		{
			onMouseOutHandler(event);
		}		
		
		/**
		 *设置按钮文本 
		 * @param text
		 * 
		 */		
		public function setText(text:String):void
		{
			LText(stateUI).text=text;
		}
		
		/**
		 *获取标签文本 
		 * @return 
		 * 
		 */
		public function getText():String
		{
			return LText(stateUI).text;
		}
	}
}