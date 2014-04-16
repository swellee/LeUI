package events
{
	import components.LComponent;
	
	import flash.display.DisplayObject;

	/**
	 *@author swellee
	 *2014-4-12
	 *
	 */
	public class LStageEvent extends LEvent
	{
		
		/**
		 *舞台点击事件 
		 */
		public static var STAGE_CLICK_EVENT:String="leui_stage_click_event";
		/**
		 *舞台上的鼠标直接对象 
		 */
		public var clickTarget:DisplayObject;
		/**
		 *LUI舞台事件 通常用作全局派发
		 * @param type 事件类型
		 * @param mouseComp 事件触发坐标处的LComponent对象
		 * @param bubbles
		 * 
		 */
		public function LStageEvent(type:String, clickTarget:DisplayObject, bubbles:Boolean=false)
		{
			super(type, bubbles, false);
			this.clickTarget=clickTarget;
		}
	}
}