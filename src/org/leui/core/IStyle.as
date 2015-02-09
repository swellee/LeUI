package org.leui.core
{
	import flash.display.DisplayObject;

	/**
	 *  可使用样式的组件 
	 * @author swellee
	 * 
	 */
	public interface IStyle extends IDispose
	{
		/**  样式名*/
		function get style():String;
		function set style(value:String):void;
		/**
		 *  获取默认样式名 ,默认为类名
		 */
		function getDefaultStyle():String;
		/**  置回默认样式*/
		function resetStyle():void;
		
		/**  设置背景*/
		function setBg(asset:DisplayObject):void;
		/**  清除背景*/
		function clearBg():void;
	}
}