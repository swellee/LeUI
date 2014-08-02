package org.leui.core
{
	import org.leui.vos.StyleVO;

	/**
	 *  装饰器 
	 * @author swellee
	 * 
	 */	
	public interface IDecorator
	{
		/**
		 *  装饰组件 
		 * @param ui 组件
		 * @param styleVo 样式对象
		 * 
		 */		
		function decorate(ui:IStyle,styleVo:StyleVO):void;
	}
}