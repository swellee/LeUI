package org.leui.events
{
	/**
	 *  步进器事件
	 *@author swellee
	 */
	public class LStepperEvent extends LEvent
	{
		/**
		 *LStepper值变化 
		 */
		public static const VALUE_CHANGED:String = "LSTEPPER_VALUE_CHANGED";
		public function LStepperEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}