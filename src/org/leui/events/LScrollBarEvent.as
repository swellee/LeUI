package org.leui.events
{
	/**
	 *@author swellee
	 *2013-8-4
	 *滚动条事件
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