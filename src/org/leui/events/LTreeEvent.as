package org.leui.events
{
	/**
	 *  树容器 相关事件
	 *@author swellee
	 */
	public class LTreeEvent extends LEvent
	{
		public static const TREE_NODE_STATUS_CHANGED:String="tree_node_status_changed";
		public function LTreeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}