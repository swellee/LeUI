package org.leui.utils
{
	import flash.events.KeyboardEvent;

	/**
	 *@author swellee
	 *2013-2-14
	 * 记录打印日志
	 */
	public class LTrace
	{
		private static var _log:String;
		private static var infoWindow:LTraceWindow;
		/**
		 *打印日志 
		 * @param msg
		 * 
		 */
		public static function log(...msg):void
		{
			var msgCount:int=msg.length;
			var str:String="";
			while(msg.length>0)
			{
				str+=toString(msg.shift())+"\n";
			}
			record(str);
		}
		
		public static function warnning(...msg):void
		{
			msg.unshift("Warnning!-----------------------------------------");
			msg.push("----------------------------------------------------");
			log.apply(null,msg);
		}
		
		private static function record(str:String):void
		{
			trace(str);
			_log+=str;
			if(infoWindow)
			{
				infoWindow.appendLog(str);
			}
		}
		
		private static function toString(msg:*):String
		{
			return msg is String?msg:msg.toString();
		}
		
		public static function clear():void
		{
			_log="";
		}
		
		/**
		 *将日志通过一个弹窗显示出来 
		 * 
		 */
		public static function showLogFrame():void
		{
			infoWindow.show();
		}
		
		public static function hideLogFrame():void
		{
			infoWindow.hide();
		}
		
		public static function init():void
		{
			if(!infoWindow)
			{
				infoWindow=new LTraceWindow();
				LUIManager.addKeyUpListener(listenKeyUp);
			}
		}
		
		private static function listenKeyUp(evt:KeyboardEvent):void
		{
			if(evt.ctrlKey&&evt.keyCode==UiConst.LTRACE_HOTKEY)
			{
				infoWindow.isShowing?infoWindow.hide():infoWindow.show();
			}
		}
	}
}