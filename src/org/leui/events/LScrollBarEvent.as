package org.leui.events
{
	/**
	 *  滚动条事件
	 *@author swellee
	 */
	public class LScrollBarEvent extends LEvent
	{
		public static const VALUE_CHANGE:String="scrollbar_value_change";
		public function LScrollBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}