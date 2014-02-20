package core
{
	/**
	 *布局管理器 
	 * @author Administrator
	 * 
	 */
	public interface IlayoutManager
	{
		/**
		 *管理容器的布局 
		 * @param contianer
		 * 
		 */
		function doLayout(contianer:IlayoutContainer):void;
	}
}