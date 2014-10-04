package org.leui.events
{
	import flash.events.Event;
	
	/**
	 *  LeUI事件
	 *@author swellee
	 */
	public class LEvent extends Event
	{
		/**
		 *更换整体样式表 收到此消息后，组件实例需要更新样式 
		 */
		public static const STYLE_SHEET_CHANGED:String="leui_style_sheet_changed";
		/**
		 *菜单项鼠标悬停 
		 */
		public static const MOUSE_OVER_MENU_ITEM:String="leui_mouse_over_menu_item";
		/**
		 *事件附带的数据 
		 */
		public var data:*;
		public function LEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}