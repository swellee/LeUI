package org.leui.components
{
	
	import flash.display.DisplayObject;
	
	import org.leui.core.IDispose;
	import org.leui.core.ILayoutElement;
	import org.leui.core.IMatirxContainer;
	import org.leui.events.LTreeEvent;
	import org.leui.layouts.TreeLayout;
	import org.leui.utils.LeSpace;

	use namespace LeSpace;

	/**
	 *  树容器
	 *@author swellee
	 */
	public class LTree extends LPane implements IMatirxContainer
	{
		private var rootNode:LTreeNode;
		private var _hGap:int;
		private var _vGap:int;
		private var _nodeWidth:int;
		private var _nodeHeight:int;
		private var _selectedNode:LTreeNode;
		/**
		 * 选中节点更换时的回调函数 
		 */
		private var selectedChangeFun:Function;
		/**
		 *   树容器,初始化时强烈建议提供根节点，若不提供，就自动生成一个LTreeNode作为根节点，后续不可重设根节点，只能对已有的根节点修改
		 * @param root 根节点 如果构造函数中不提供要节点，则自动生成一个“root”标签的根节点，后续如需修改，请使用getRootNode()方法获取根节点
		 * @param hGap 节点与子级节点的横向间距
		 * @param vGap 节点与子级节点的竖向间距
		 * @param nodeWidth 节点统一宽度
		 * @param nodeHeight 节点统一高度
		 * 
		 */
		public function LTree(root:LTreeNode=null,hGap:int=10,vGap:int=2,nodeWidth:int = 80, nodeHeight:int=20)
		{
			super();
			this._hGap=hGap;
			this._vGap=vGap;
			this.nodeWidth=nodeWidth;
			this._nodeHeight=nodeHeight;
			setRootNode(root);
		}
		
		/**
		 *  选中的节点 
		 */
		public function get selectedNode():LTreeNode
		{
			return _selectedNode;
		}

		/**
		 * @private
		 */
		public function set selectedNode(value:LTreeNode):void
		{
			if(_selectedNode == value)return;
			//清除旧的选中状态
			if(_selectedNode)_selectedNode.ele_label_btn.selected = false;
			_selectedNode = value;
			//设置新的选中状态
			_selectedNode.ele_label_btn.selected = true;
			//如果设置的该节点尚未显示，则使其显示
			if(!_selectedNode.parent)
			{
				if(_selectedNode.parentNode)
					_selectedNode.parentNode.extracted = true;
			}
			//执行回调
			if(selectedChangeFun!=null)selectedChangeFun();
		}

		/**
		 *  节点统一宽度 
		 * @return 
		 * 
		 */
		public function get nodeWidth():int
		{
			return _nodeWidth;
		}

		public function set nodeWidth(value:int):void
		{
			_nodeWidth = value;
		}

		/**
		 *  节点统一高度 
		 * @return 
		 * 
		 */
		public function get nodeHeight():int
		{
			return _nodeHeight;
		}

		public function set nodeHeight(value:int):void
		{
			_nodeHeight = value;
			updateLayout();
		}
		
		public function listenSelectedNodeChange(fun:Function):void
		{
			this.selectedChangeFun = fun;
		}
		
		/**
		 *  显示中的节点总数 
		 * @return 
		 * 
		 */
		public function getDisplayNodesCount():int
		{
			return container.numChildren;
		}

		private function setRootNode(node:LTreeNode):void
		{
			if(rootNode)return;
			this.rootNode=node||new LTreeNode("root");
			rootNode.depth=0;
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			addEventListener(LTreeEvent.TREE_NODE_STATUS_CHANGED,onTreeNodeStatusChange);
			addEventListener(LTreeEvent.TREE_NODE_SELECTED_CHANGED,onTreeNodeSelectedChange);
		}
		
		override protected function removeEvents():void
		{
			super.removeEvents();
			removeEventListener(LTreeEvent.TREE_NODE_SELECTED_CHANGED,onTreeNodeSelectedChange);
			removeEventListener(LTreeEvent.TREE_NODE_STATUS_CHANGED,onTreeNodeStatusChange);
		}
		
		protected function onTreeNodeSelectedChange(event:LTreeEvent):void
		{
			var node:LTreeNode = event.target as LTreeNode;
			if(node)
			{
				selectedNode = node;
			}
		}
		
		protected function onTreeNodeStatusChange(event:LTreeEvent):void
		{
			updateLayout();
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=TreeLayout;
		}
		
		/**
		 *  此值无效 
		 * @param val
		 * 
		 */
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
		 *   获取根节点 
		 * @return 
		 * 
		 */
		public function getRootNode():LTreeNode
		{
			return rootNode;
		}
		
		// restrict these follow functions to accept only LTreeNode child----------------------
		override public function append(child:DisplayObject, layoutImmediately:Boolean=true):void
		{
			getRootNode().appendChildrenNode(child);
		}
		override public function appendAll(...elements):void
		{
			getRootNode().appendChildrenNode.apply(null,elements);
		}
		///---------------------------------------------------------------------------------------
		//override these functions to avoid updatelayout---------------------------------------
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
			if(removingBgAsset)
			{
				return super.removeChildAt(index);
			}
			var child:DisplayObject=container.removeChildAt(index);
			return child;
		}
		///---------------------------------------------------------------------------------------------
		override public function dispose():void
		{
			rootNode=null;
			super.dispose();
		}
	}
}