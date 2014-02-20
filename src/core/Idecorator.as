package core
{
	import vos.StyleVO;

	/**
	 *装饰器 
	 * @author swellee
	 * 
	 */	
	public interface Idecorator
	{
		/**
		 *装饰组件 
		 * @param ui 组件
		 * @param styleVo 样式对象
		 * 
		 */		
		function decorate(ui:Istyle,styleVo:StyleVO):void;
	}
}