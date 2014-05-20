package org.leui.core
{
	import org.leui.vos.ChildStyleHashVO;

	/**
	 * 组合UI,由多个子组件拼合而成，典型子类如LScrollBar、LScrollPane,LRadioButton
	 * @author swellee
	 * 
	 */	
	public interface ICombine
	{
		/**
		 *子组件名称－样式映射表 
		 * @return 
		 * 
		 */		
		function get elementStyleHash():Vector.<ChildStyleHashVO>;
		/**
		 *设置子组件样式 
		 * @param elementName 子组件名称
		 * @param styleName 子组件样式
		 * @return 
		 * 
		 */
		function setElementStyle(elementName:String,styleName:String):void;
		/**
		 *应用 elementStyleHash中为子组件设置的样式
		 * 
		 */
		function applyElementStyles():void;
	}
}