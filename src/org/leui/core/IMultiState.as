package org.leui.core
{
	import org.leui.vos.ChildStyleHashVO;
	
	/**
	 *  具有多种状态的UI组件，典型的如Button
	 * </br>装饰类对组件完成样式组装后，会显示stateStyleHash中第一个状态的样式
	 * @author swellee
	 */	
	public interface IMultiState
	{
		/**
		 *  状态名-状态样式映射数组, 
		 * </br>组件初始化时，会生成此原始的ChildStyleHashVO序列
		 * </br>这些ChildStyleHashVO保存了状态名信息，
		 * </br>外部对象或样式表StyleSheet中可通过状态名信息相应地设置对应的状态样式
		 * @return 
		 * 
		 */		
		function get stateStyleHash():Vector.<ChildStyleHashVO>;
		/**
		 *  获取状态对应的样式名 
		 * @param stateType 状态名
		 * @return 样式名
		 * 
		 */
		function getStateStyle(stateType:String):String;
		/**
		 *  显示状态 
		 * @param stateType 状态类型
		 * </br>传入参数为null,则使用状态样式表里的第一个状态样式
		 */
		function showState(stateType:String=null):void;
	}
}