package org.leui.core
{
	import flash.geom.Rectangle;

	/**
	 *  可被用于布局的组件，接口方法供IlayouManager对象使用
	 * @author swellee
	 * 
	 */
	public interface ILayoutElement extends IStyle
	{
		/**  作为被布局的元素时，是否可横向缩放,默认为true*/
		function get canScaleX():Boolean;
		function set canScaleX(value:Boolean):void;
		/**  作为被布局的元素时，是否可纵向缩放,默认为true*/
		function get canScaleY():Boolean;
		function set canScaleY(value:Boolean):void;
		/**  边界矩形*/
		function get bounds():Rectangle;
		/**
		 *  是否作为列表项；当直接父容器是IlistContainer类型时，此值为true 
		 * @return 
		 * 
		 */
		function get isListCell():Boolean;
		/**
		 *  设置XY坐标 
		 * @param x
		 * @param y
		 * 
		 */
		function setXY(x:int,y:int):void;
		/**
		 *  设置宽高 
		 * @param width 传入-1将不改变原宽度
		 * @param height 传入-1将不改变原高度
		 * 
		 */
		function setWH(width:int=-1,height:int=-1):void;
		
	}
}