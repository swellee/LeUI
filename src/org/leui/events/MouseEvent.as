package org.leui.events
{
	/**
	 * starling屏蔽了鼠标事件，LeUI为保证与之前版本api的一致性，由starling事件体系，模拟鼠标事件 
	 * @author swellee
	 * 
	 */
	public class MouseEvent extends LEvent
	{
		public static const ROLL_OUT:String = "leui_ms_roll_out";
		public static const ROLL_OVER:String = "leui_ms_roll_over";
		public static const MOUSE_DOWN:String = " leui_ms_ms_down";
		public static const MOUSE_UP:String = "leui_ms_ms_up";
		public static const CLICK:String = "leui_ms_ms_click";
		public static const DOUBLE_CLICK:String = "leui_ms_ms_double_click";
		public function MouseEvent(type:String, bubbles:Boolean=false, data:*=null)
		{
			super(type, bubbles, data);
		}
	}
}