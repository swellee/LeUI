package org.leui.core
{
	import flash.events.Event;

	/**
	 * UI组件其类接口
	 * @author swellee
	 * 
	 */
	public interface IComponent extends  ILayoutElement
	{
		/**
		 *派发全局事件 
		 * @param event
		 * 
		 */
		function dispatchGlobalEvent(event:Event):void;
		/**
		 *添加全局事件监听 
		 * @param eventType
		 * @param listenFun
		 * 
		 */
		function addGlobalEventListener(eventType:String,listenFun:Function):void;
		/**
		 * 移除全局事件监听
		 * @param eventType
		 * @param listenFun
		 * 
		 */		
		function removeGlobalEventListener(eventType:String, listenFun:Function):void
		/**是否可用，不可用时会添加灰色滤镜并停止响应鼠标事件*/
		function get enabled():Boolean;
		function set enabled(value:Boolean):void;
		/**选中状态*/
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		/**
		 *附带数据 
		 * @return 
		 * 
		 */		
		function get data():*;
		function set data(val:*):void;
	}
}