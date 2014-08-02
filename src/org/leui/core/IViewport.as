package org.leui.core
{
	import flash.geom.Rectangle;
	

	/**
	 *  视口,用于LScrollPane内 ,实现了该接口的常用组件有：LPane、 LText
	 * @author swellee
	 * 
	 */
	public interface IViewport extends IComponent
	{
		/**
		 *  设置视口左上点坐标 
		 * @param posX
		 * @param posY
		 * 
		 */
		function setViewPosition(posX:Number,posY:Number):void;
		
		/**
		 *  视口宽 
		 */
		function get viewWidth():int;
		/**
		 *   视口高
		 */
		function get viewHeight():int;
		/**
		 *  添加视口尺寸变化时的监听函数 
		 * @param fun
		 * 
		 */
		function addViewSizeListener(fun:Function):void;
		/**
		 *   移除视口尺寸变化时的监听函数
		 * @param fun
		 * 
		 */
		function removeViewSizeListener():void;
	}
}