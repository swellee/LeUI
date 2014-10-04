package org.leui.core
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	/**
	 *   可布局的容器 
	 * @author swellee
	 * 
	 */
	public interface ILayoutContainer extends ILayoutElement
	{
		
		/**
		 *  设置布局管理类  
		 * @param layoutManager 布局类
		 * 
		 */
		function setLayoutManager(layoutManager:Class):void;
		/**
		 *  获取布局管理类 
		 * @return 
		 * 
		 */
		function getLayoutManager():Class;
		/**
		 *  获取容器中存放的可被布局的子元素 
		 * @return 
		 * 
		 */
		function get layoutElements():Vector.<ILayoutElement>;
		/**
		 *  添加子元素到容器中 
		 * @param child 显示对象
		 * @param layoutImmediately 是否立即更新布局
		 * 
		 */
		function append(child:DisplayObject, layoutImmediately:Boolean=true):void;
		/**
		 *  一次添加多个 IlayoutElement类型的子组件
		 * </br>非 IlayoutElement类型的子组件将被丢弃
		 *  </br>相比append方法，此方法会在添加完参数列表中的所有子组件后才更新一次布局，因此更节约性能
		 */
		function appendAll(...elements):void;
		/**
		 *  将子元素从显示列表和子元素列表中移除
		 * @param element 子元素
		 * @param dispose 是否销毁
		 * @param layoutImmediately 是否立即更新布局
		 * @return 被移除的子元素（子元素内部数据可能已销毁）
		 * 
		 */
		function remove(child:DisplayObject,dispose:Boolean=true, layoutImmediately:Boolean=true):DisplayObject;
		/**
		 *  移除全部子元素 
		 * @param dispose 是否销毁
		 * 
		 */
		function removeAll(dispose:Boolean=true):void;
		/**  立即更新布局*/
		function updateLayout():void;
		/**
		 *  获取内容边界矩形（包含了所有已添加到该容器的显示对象的最小边界） 
		 * @return 
		 * 
		 */
		function getContentBounds():Rectangle;
		/**  自动缩放尺寸到刚好能够包裹子对象*/
		function pack():void;
	}
}