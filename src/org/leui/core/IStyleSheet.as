package org.leui.core
{
	import org.leui.vos.StyleVO;

	/**
	 *样式表 
	 * @author swellee
	 * 
	 */
	public interface IStyleSheet
	{
		/**
		 *存入样式对象 
		 * @param styleVo 样式对象
		 * 
		 */		
		function putStyleVO(styleVo:StyleVO):void;
		/**
		 *获取样式对象 
		 * @param styleName 样式名
		 * @return 样式对象
		 * 
		 */
		function getStyleVO(styleName:String):StyleVO;
	}
}