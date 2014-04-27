package core
{
	import utils.LUIManager;

	/**
	 *弹出类组件,此类型组件的父容器统一为		LUIManager.uiContainer;
	 * 设置数据后，调用show()显示；调用hide()隐藏；如果要销毁，需调用hide(true)进行隐藏并销毁。
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
		/**
		 *是否为显示状态 
		 */
		function get isShowing():Boolean;
		
	}
}