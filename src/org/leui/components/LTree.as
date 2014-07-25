package org.leui.components
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import org.leui.core.IDispose;
	import org.leui.core.ILayoutElement;
	import org.leui.core.IMatirxContainer;
	import org.leui.errors.LError;
	import org.leui.events.LTreeEvent;
	import org.leui.layouts.TreeLayout;
	import org.leui.utils.LeSpace;

	use namespace LeSpace;

	/**
	 *@author swellee
	 *2014-2-22
	 *树容器,初始化时必须提供根节点
	 */
	public class LTree extends LPane implements IMatirxContainer
	{
		private var rootNode:LTreeNode;
		private var _hGap:int;
		private var _vGap:int;
		private var _nodeHeight:int;
		/**
		 * 树容器,初始化时必须提供根节点
		 * @param root 根节点 如果构造函数中不提供要节点，则自动生成一个“root”标签的根节点，后续如需修改，请使用getRootNode()方法获取根节点
		 * @param hGap 节点与子级节点的横向间距
		 * @param vGap 节点与子级节点的竖向间距
		 * 
		 */
		public function LTree(root:LTreeNode=null,hGap:int=10,vGap:int=2,nodeHeight:int=20)
		{
			super();
			this._hGap=hGap;
			this._vGap=vGap;
			this._nodeHeight=nodeHeight;
			setRootNode(root);
		}
		
		public function get nodeHeight():int
		{
			return _nodeHeight;
		}

		public function set nodeHeight(value:int):void
		{
			_nodeHeight = value;
			updateLayout();
		}
		
		public function getDisplayNodesCount():int
		{
			return container.numChildren;
		}

		private function setRootNode(node:LTreeNode):void
		{
			if(rootNode)return;
			this.rootNode=node||new LTreeNode("root");
			rootNode.depth=0;
			updateLayout();
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			addEventListener(LTreeEvent.TREE_NODE_STATUS_CHANGED,onTreeNodeStatusChange);
		}
		
		override protected function removeEvents():void
		{
			super.removeEvents();
			removeEventListener(LTreeEvent.TREE_NODE_STATUS_CHANGED,onTreeNodeStatusChange);
		}
		
		protected function onTreeNodeStatusChange(event:Event):void
		{
			updateLayout();
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=TreeLayout;
		}
		
		public function set direction(val:int):void
		{
		}
		
		public function get direction():int
		{
			return 0;
		}
		
		public function set hGap(val:int):void
		{
			if(val==_hGap)return;
			_hGap=val;
			updateLayout();
		}
		
		public function get hGap():int
		{
			return _hGap;
		}
		
		public function set vGap(val:int):void
		{
			if(val==_vGap)return;
			_vGap=val;
			updateLayout();
		}
		
		public function get vGap():int
		{
			return _vGap;
		}
		
		/**
		 *获取根节点 
		 * @return 
		 * 
		 */
		public function getRootNode():LTreeNode
		{
			return rootNode;
		}
		
		// restrict these follow functions to avoid be used as container
		override public function append(child:DisplayObject, layoutImmediately:Boolean=true):void
		{
			throw new LError("cannot use 'append' function in this class");
		}
		override public function appendAll(...elements):void
		{
			throw new LError("cannot use 'appendAll' function in this class");
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			container.addChild(child);
			return child;
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			container.addChildAt(child,index);
			return child;
		}
		override public function removeAll(dispose:Boolean=true):void
		{
			while(container.numChildren)
			{
				var child:ILayoutElement=container.removeChildAt(0)as ILayoutElement;
				if(dispose&&child)
				{
					child.dispose();
				}
			}
		}
		
		override public function remove(child:DisplayObject, dispose:Boolean=true):DisplayObject
		{
			container.removeChild(child);
			if(dispose&&(child is IDispose))
			{
				(child as IDispose).dispose();
			}
			return child;
		}
		override public function  removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject=container.removeChildAt(index);
			return child;
		}
		
		override public function dispose():void
		{
			rootNode=null;
			super.dispose();
		}
	}
}