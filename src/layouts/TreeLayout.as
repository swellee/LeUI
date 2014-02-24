package layouts
{
	import components.LTree;
	import components.LTreeNode;
	
	import core.IlayoutContainer;
	import core.IlayoutManager;
	
	import utils.LeSpace;

	use namespace LeSpace;
	/**
	 *@author swellee
	 *2014-2-22
	 *树容器 布局管理器
	 */
	public class TreeLayout implements IlayoutManager
	{
		public function TreeLayout()
		{
		}
		
		public function doLayout(contianer:IlayoutContainer):void
		{
			var tree:LTree=contianer as LTree;
			if(!tree)return;
			
			tree.removeAll(false);
			layoutChildren(tree,tree.getRootNode(),true);
		}
		
		private function layoutChildren(tree:LTree,node:LTreeNode,isRoot:Boolean=false):void
		{
			//add this node to tree display
			var offx:int=node.depth*tree.hGap;;
			node.setWH(-1,tree.nodeHeight);
			if(!isRoot)	node.setXY(offx,tree.getDisplayNodesCount()*(tree.nodeHeight+tree.vGap));
			tree.addChild(node);
			
			//deal with this node's children
			if(node.extracted)//if node is extracted ,layout its children
			{
				var children:Vector.<LTreeNode>=node.getChildrenNodes();
				if(children&&children.length)
				{
					for (var i:int = 0; i < children.length; i++) 
					{
						var child:LTreeNode=children[i];
						layoutChildren(tree,child);
					}
				}
				
			}
		}
	}
}