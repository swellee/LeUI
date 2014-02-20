package events
{
	import flash.events.Event;
	
	/**
	 *@author swellee
	 *2012-11-28
	 *LeUI事件
	 */
	public class LEvent extends Event
	{
		/**
		 *更换整体样式表 收到此消息后，组件实例需要更新样式 
		 */
		public static const STYLE_SHEET_CHANGED:String="leui_style_sheet_changed";
		
		public function LEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}