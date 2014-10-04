package org.leui.components
{
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import org.leui.core.IMatirxContainer;
	import org.leui.events.LTreeEvent;
	import org.leui.layouts.BoxLayout;
	import org.leui.utils.LeSpace;
	import org.leui.utils.UiConst;
	import org.leui.vos.ChildStyleHashVO;

	use namespace LeSpace;
	/**
	 *  树节点 ,由两个LToggleButton组合而成
	 *@author swellee
	 */
	public class LTreeNode extends LCombine implements IMatirxContainer
	{
		
		public var ele_extra_btn:LToggleButton;
		public var ele_label_btn:LToggleButton;
		private var _hGap:int;
		private var _childNodes:Array;
		private var _depth:int;
		/**
		 *  父节点 
		 */
		public var parentNode:LTreeNode;
		private var _parentTree:LTree;
		private var autoHideExtraBtn:Boolean;
		/**
		 * 
		 * @param text 节点标签文本
		 * 
		 */
		public function LTreeNode(txt:String=null,autoHideExtraBtn:Boolean=true)
		{
			super();
			this.autoHideExtraBtn=autoHideExtraBtn;
			if(txt)
			{
				text = txt;
			}
		}
		
		/**
		 * 子节点列表  
		 */
		public function get childNodes():Array
		{
			return _childNodes;
		}

		/**
		 * 所在的树 
		 */
		public function get parentTree():LTree
		{
			return _parentTree;
		}

		/**
		 * @private
		 */
		public function set parentTree(value:LTree):void
		{
			if(_parentTree == value)return;
			_parentTree = value;
			_parentTree.addDisplay(this);
			if(childNodes&&childNodes.length)
			{
				for each (var node:LTreeNode in childNodes) 
				{
					node.parentTree = _parentTree;
				}
			}
			onChangeExtract();
		}

		/**
		 *在树中的层级深度（深度从0开始，0深度的节点为根节点） 
		 * 此值通过命名空间限定访问权限
		 */
		LeSpace function get depth():int
		{
			return _depth;
		}

		/**
		 * @private
		 */
		LeSpace function set depth(value:int):void
		{
			_depth = value;
			
			//更新子节点深度
			if(childNodes&&childNodes.length)
			{
				for each (var node:LTreeNode in childNodes) 
				{
					node.depth=this.depth+1;
				}
			}
		}

		/**
		 *  是否为展开状态 
		 * @return 
		 * 
		 */
		public function get extracted():Boolean
		{
			return ele_extra_btn.selected;
		}

		public function set extracted(value:Boolean):void
		{
			ele_extra_btn.selected = value;
			onChangeExtract();
		}

		override protected function initElements():void
		{
			ele_extra_btn=new LToggleButton();
			ele_extra_btn.setWH(UiConst.TREENODE_EXTRA_BTN_SIZE,UiConst.TREENODE_EXTRA_BTN_SIZE);
			ele_extra_btn.canScaleX=false;
			ele_extra_btn.canScaleY=false;
			ele_extra_btn.visible=false;
			ele_label_btn=new LToggleButton();
			addDisplay(ele_extra_btn);
			addDisplay(ele_label_btn);
			setWH(UiConst.TREENODE_EXTRA_BTN_SIZE+UiConst.TEXT_DEFAULT_WIDTH,UiConst.ICON_DEFAULT_SIZE);
		}
		
		override protected function initElementStyleHash():void
		{
			super.initElementStyleHash();
			elementStyleHash.push(new ChildStyleHashVO("ele_extra_btn"));
			elementStyleHash.push(new ChildStyleHashVO("ele_label_btn"));
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			ele_label_btn.addEventListener(MouseEvent.CLICK,onClickLabel);
			ele_extra_btn.addEventListener(MouseEvent.CLICK,onChangeExtract);
		}
		override protected function removeEvents():void
		{
			super.removeEvents();
			ele_label_btn.removeEventListener(MouseEvent.CLICK,onClickLabel);
			ele_extra_btn.removeEventListener(MouseEvent.CLICK,onChangeExtract);
		}
		
		/**
		 *  切换展开/闭合 
		 * @param event
		 * 
		 */
		protected function onChangeExtract(event:MouseEvent=null):void
		{
			dispatchEvent(new LTreeEvent(LTreeEvent.TREE_NODE_STATUS_CHANGED,true));
		}
		/**
		 *  点击标签文本
		 * @param event
		 * 
		 */
		protected function onClickLabel(event:MouseEvent=null):void
		{
			dispatchEvent(new LTreeEvent(LTreeEvent.TREE_NODE_SELECTED_CHANGED,true));
		}
		/**
		 *  添加子节点 
		 * @param children LTreeNode 类型
		 * 
		 */
		public function appendChildrenNode(...children):void
		{
			_childNodes ||= [];
			while(children.length)
			{
				var node:LTreeNode=children.shift() as LTreeNode;
				if(!node)continue;
				if(childNodes.indexOf(node)>-1)continue;
				
				node.depth=this.depth+1;
				node.parentNode = this;
				node.parentTree = this.parentTree;
				childNodes.push(node);
			}
			ele_extra_btn.visible=childNodes.length>0;
			onChangeExtract();
		}
		
		public function removeNode(node:LTreeNode,layoutImmediately:Boolean = true):void
		{
			if(!node)return;
			if(!childNodes)return;
			var idx:int = childNodes.indexOf(node);
			if(idx ==-1)return;
			
			childNodes.splice(idx,1);
			ele_extra_btn.visible=childNodes.length>0;
			
			if(layoutImmediately)
			{
				if(childNodes.length==0)
				{
					ele_extra_btn.visible=false;
				}
				onChangeExtract();
			}
		}
		
		/**
		 *   删除子节点
		 * @param children LTreeNode 类型
		 * 
		 */
		public function removeChildrenNode(...children):void
		{
			for each (var node:LTreeNode in children) 
			{
				removeNode(node,false);
			}

			onChangeExtract();
		}
		
		/**
		 *  根据索引 删除子节点 
		 * @param idx 子级节点的索引，从0开始
		 * 
		 */
		public function removeChildNodeAt(idx:int):void
		{
			if(idx>=0&&childNodes&&childNodes.length>idx)
			{
				childNodes.splice(idx,1);
			}
			ele_extra_btn.visible=childNodes.length>0;
			onChangeExtract();
		}
		
		// restrict these follow functions to accept only LTreeNode child
		override public function append(child:DisplayObject, layoutImmediately:Boolean=true):void
		{
			appendChildrenNode(child);
		}
		override public function appendAll(...elements):void
		{
			appendChildrenNode.apply(this,elements);
		}
		override public function getLayoutManager():Class
		{
			return _layoutManager||=BoxLayout;
		}
		
		public function set direction(val:int):void
		{
		}
		public function get direction():int
		{
			return UiConst.HORIZONTAL;
		}
		public function set hGap(val:int):void
		{
			if(_hGap==val)return;
			_hGap=val;
			updateLayout();
		}
		public	function get hGap():int
		{
			return _hGap;
		}
		public	function set vGap(val:int):void
		{
		}
		public	function get vGap():int
		{
			return 0;
		}
		/**
		 *   节点标签文本 
		 * @param text
		 * 
		 */
		public function set text(txt:String):void
		{
			ele_label_btn.text = txt;
		}
		public function get text():String
		{
			return ele_label_btn.text ;
		}
		
		//override this function to accept subNodes by calling append/appendAll
		override public function get contentPane():LContainer
		{
			return this;
		}
		
		override public function dispose():void
		{
			_childNodes=null;
			_parentTree = null;
			parentNode = null;
			super.dispose();
		}
	}
}