package core
{
	import utils.LUIManager;

	/**
	 *弹出类组件,此类型组件的父容器统一为		LUIManager.uiContainer
	 *2014-4-13
	 *@author swellee
	 */
	public interface IPopup extends IDispose
	{
		/**
		 * 
		 * 显示
		 */
		function show():void;
		/**
		 *隐藏 
		 * @param disposeThis 隐藏时是否销毁
		 * 
		 */
		function hide(disposeThis:Boolean=false):void;
	}
}