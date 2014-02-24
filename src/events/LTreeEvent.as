package events
{
	/**
	 *@author swellee
	 *2014-2-22
	 *树容器 相关事件
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