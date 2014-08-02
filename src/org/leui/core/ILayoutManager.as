package org.leui.core
{
	/**
	 *  布局管理器 
	 * @author swellee
	 * 
	 */
	public interface ILayoutManager
	{
		/**
		 *  管理容器的布局 
		 * @param contianer
		 * 
		 */
		function doLayout(contianer:ILayoutContainer):void;
	}
}