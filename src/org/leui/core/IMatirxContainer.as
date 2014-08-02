package org.leui.core
{
	/**
	 *   阵列容器
	 * @author swellee
	 * 
	 */	
	public interface IMatirxContainer extends ILayoutContainer
	{
		
		function set direction(val:int):void;
		/**
		 *  布局朝向，可用值为 UiConst.VERTICAL、UiConst.HORIZONTAL
		 * @return 
		 * 
		 */
		function get direction():int;
		
		function set hGap(val:int):void;
		/**
		 *  布局时，子对象的横向间距（像素） 
		 * @return 
		 * 
		 */
		function get hGap():int;
		
		function set vGap(val:int):void;
		/**
		 *  布局时，子对象的竖向间距（像素）
		 * @return 
		 * 
		 */
		function get vGap():int;
	}
}