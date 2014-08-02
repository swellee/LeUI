package org.leui.core
{
	import org.leui.components.LContainer;

	/**
	 *  转嫁容器，此类容器将容器属性转嫁给自己的子容器，常见的有LScrollPane、LWindow、Alert等及其活派生类 
	 * @author lishiwei
	 * 
	 */
	public interface IContentContainer
	{
		/**
		 *获取真正作为容器的子对象 
		 * @return 
		 * 
		 */
		function getContainer():LContainer;
	}
}