package org.leui.utils
{
	import flash.filters.ColorMatrixFilter;
	
	import org.leui.components.LComponent;

	/**
	 * 滤镜管理
	 *@author swellee
	 */
	public class LFilters
	{
		
		private static const grayFilterMatrix:Array = [0.3, 0.6, 0.1, 0, 0, 0.3, 0.6, 0.1, 0, 0, 0.3, 0.6, 0.1, 0, 0, 0, 0, 0, 1, 0];
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
				comp.filters=comp.filters.concat(LFilters.GRAY_FILTER);
				comp.mouseChildren=false;
				comp.mouseEnabled=false;
			}
			else
			{
				comp.mouseChildren=true;
				comp.mouseEnabled=true;
				var cache:Array=comp.filters.concat();
				for (var i:int = 0; i < cache.length; i++) 
				{
					var f:ColorMatrixFilter=cache[i]as ColorMatrixFilter;
					if(f)
					{
						if(similarToGrayFilter(f.matrix))
						{
							cache.splice(i,1);
							break;
						}
					}
				}
				comp.filters=cache;
			}
		}
		
		private static function similarToGrayFilter(fMatrix:Array):Boolean
		{
			var grayMatrix:Array=LFilters.GRAY_FILTER.matrix;
			if(int(fMatrix[1]/fMatrix[0])==int(grayMatrix[1]/grayMatrix[0])
				&& int(fMatrix[1]/fMatrix[2])==int(grayMatrix[1]/grayMatrix[2]))
				return true;
			return false;
		}
	}
}