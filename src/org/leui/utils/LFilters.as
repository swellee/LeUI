package org.leui.utils
{
	
	import org.leui.components.LComponent;
	
	import starling.filters.ColorMatrixFilter;

	/**
	 * 滤镜管理
	 *@author swellee
	 */
	public class LFilters
	{
		
		private static const grayFilterMatrix:Vector.<Number> = new <Number>[0.3, 0.6, 0.1, 0, 0, 0.3, 0.6, 0.1, 0, 0, 0.3, 0.6, 0.1, 0, 0, 0, 0, 0, 1, 0];
		/**
		 * 灰度滤镜
		 */
		public static const GRAY_FILTER:ColorMatrixFilter=new ColorMatrixFilter(grayFilterMatrix);
		
		/**
		 *  根据组件的enabled，设置组件的灰度滤镜 
		 * @param comp
		 * 
		 */
		public static function setEnableFilter(comp:LComponent):void
		{
			if(!comp.enabled)
			{
				comp.filter=LFilters.GRAY_FILTER;
				comp.touchGroup=true;
				comp.touchable=false;
			}
			else
			{
				comp.touchGroup=false;
				comp.touchable=true;
				comp.filter=null;
			}
		}
	}
}