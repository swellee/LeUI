package org.leui.layouts
{
	import org.leui.components.LTree;
	import org.leui.components.LTreeNode;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutManager;
	import org.leui.utils.LeSpace;

	use namespace LeSpace;
	/**
	 *  树容器 布局管理器
	 *@author swellee
	 */
	public class TreeLayout implements ILayoutManager
	{
		public function TreeLayout()
		{
		}
		
		public function doLayout(contianer:ILayoutContainer):void
		{
			var treeUI:LTree=contianer as LTree;
			if(!treeUI)return;
			
			var locX:int;
			var locY:int;
			layoutNode(treeUI.getRootNode());
			// use anonymous function to store locY's value
			function layoutNode(node:LTreeNode):void
			{
				var tree:LTree = node.parentTree;
				if(!tree)return;
				locX = node.depth*tree.hGap;
				node.setXY(locX,locY);
				node.setWH(tree.nodeWidth,tree.nodeHeight);
				node.visible = node.enabled =node.depth ==0 || node.parentNode.extracted;
				locY += node.visible? (tree.vGap +tree.nodeHeight):0;
				//sub nodes
				if(node.childNodes&&node.childNodes.length)
				{
					var len:int = node.childNodes.length;
					for (var i:int = 0; i < len; i++) 
					{
						layoutNode(node.childNodes[i]);
					}
					
				}
			}
		}
		
	}
}