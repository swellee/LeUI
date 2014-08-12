package org.leui.events
{
	/**
	 *  树容器 相关事件
	 *@author swellee
	 */
	public class LTreeEvent extends LEvent
	{
		/**
		 * 树节点展开状态变化 
		 */
		public static const TREE_NODE_STATUS_CHANGED:String="tree_node_status_changed";
		/**
		 * 树节点选中变化 
		 */
		public static const TREE_NODE_SELECTED_CHANGED:String="TREE_NODE_SELECTED_CHANGED";
		public function LTreeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}