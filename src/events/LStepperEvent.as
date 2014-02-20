package events
{
	/**
	 *@author swellee
	 *2013-12-5
	 *
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