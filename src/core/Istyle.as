package core
{
	import flash.display.DisplayObject;
	/**
	 *可使用样式的组件 
	 * @author swellee
	 * 
	 */
	public interface Istyle extends IDispose
	{
		/**样式名*/
		function get style():String;
		function set style(value:String):void;
		/**
		 *获取默认样式名 ,默认为类名
		 * @return 
		 * 
		 */
		function getDefaultStyleName():String;
		/**置回默认样式*/
		function resetStyle():void;
		
		/**设置背景*/
		function setBg(asset:DisplayObject):void;
	}
}