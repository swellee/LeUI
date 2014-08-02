package org.leui.core
{
	import org.leui.components.LContainer;
	import org.leui.vos.ChildStyleHashVO;

	/**
	 *   组合UI,由多个子组件拼合而成，典型子类如LScrollBar、LScrollPane,LRadioButton
	 * @author swellee
	 * 
	 */	
	public interface ICombine
	{
		/**
		 *  子组件名称－样式映射表 
		 * @return 
		 * 
		 */		
		function get elementStyleHash():Vector.<ChildStyleHashVO>;
		/**
		 *  设置子组件样式 
		 * @param elementName 子组件名称
		 * @param styleName 子组件样式
		 * @return 
		 * 
		 */
		function setElementStyle(elementName:String,styleName:String):void;
		/**
		 *  应用 elementStyleHash中为子组件设置的样式
		 * 
		 */
		function applyElementStyles():void;
		
		/**
		 *  内容面板，因为 ICombine 组件由多个组件拼合而成，虽然直接父类为LContainer，但如果作为普通容器使用时，通常将容器属性转嫁给自身的某个组合元素。
		 * 使用contentPane可得此组合元素，并向其中添加子对象。
		 * </br>注意，有些功能性ICombine的contentPane可能是null，因为这些复合组件拒绝接收子对象（如LRadioButton、LCombox、LScrollBar等)
		 * @return 
		 * 
		 */
		function get contentPane():LContainer;
	}
}