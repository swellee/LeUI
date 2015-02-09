package org.leui.components
{
	
	import flash.geom.Rectangle;
	
	import org.leui.core.IDispose;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutElement;
	import org.leui.core.InnerContainer;
	import org.leui.layouts.BasicLayout;
	import org.leui.utils.LUIManager;
	import org.leui.utils.LeSpace;
	import org.leui.utils.UiConst;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	use namespace LeSpace
	
	/**
	 *  容器基类,定义了作为容器的基本方法。
	 *</br>推荐使用其功能封装更全面的子类，如LPane、LBox、LList、LGrid等
	 *@author swellee
	 */
	public class LContainer extends LComponent implements ILayoutContainer
	{
		protected var _layoutElements:Vector.<ILayoutElement>;
		protected var _layoutManager:Class;
		private var needRenderLayout:Boolean;
		/**显示对象的真正容器*/
		protected var container:InnerContainer;
		public function LContainer()
		{
			super();
		}


		override protected function init():void
		{
			super.init();
			if(!container)
			{
				container=new InnerContainer();
				container.clipRect=null;
				super.addChildAt(container,0);
			}
		}
		override protected function onActive(event:Event):void
		{
			super.onActive(event);
			if(!isCompElement)
			{
				updateLayout();
			}
		}
		public function setLayoutManager(layoutManager:Class):void
		{
			_layoutManager=layoutManager;
			updateLayout();
		}
		
		public function getLayoutManager():Class
		{
			return _layoutManager||=BasicLayout;
		}
		
		public function get layoutElements():Vector.<ILayoutElement>
		{
			return _layoutElements||=new Vector.<ILayoutElement>();
		}
		public function remove(child:DisplayObject,dispose:Boolean=true, layoutImmediately:Boolean=true):DisplayObject
		{
			removeDisplay(child,dispose);
			if(layoutImmediately)
			{
				updateLayout();
			}
			return child;
		}
		public function removeAll(dispose:Boolean=true):void
		{
			while(layoutElements.length>0)
			{
				var ele:ILayoutElement=layoutElements[0] ;
				remove(ele as DisplayObject,dispose,false);
				updateLayout();
			}
		}
		
		/**
		 *  从容器中移除显示对象 
		 * @param child
		 * 
		 */
		internal function removeDisplay(child:DisplayObject, dispose:Boolean=false):void
		{
			checkAndPopElement(child);
			if(container.contains(child))	container.removeChild(child,dispose);
		}
		
		/**
		 * 向容器中添加显示对象 
		 * @param child
		 * 
		 */
		internal function addDisplay(child:DisplayObject):void
		{
			container.addChild(child);
			checkAndPushElement(child);
		}
		public function append(child:DisplayObject, layoutImmediately:Boolean=true):void
		{
			addDisplay(child);
			if(layoutImmediately)
			{
				updateLayout();
			}
		}
		public function appendAll(...elements):void
		{
			for (var i:int = 0; i < elements.length; i++) 
			{
				var ele:DisplayObject=elements[i]as DisplayObject;
				if(ele)
				{
					append(ele,false);
				}
			}
			updateLayout();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			addDisplay(child);
			updateLayout();
			return child;
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			if(addingBgAsset)
			{
				addingBgAsset = false;
				return super.addChildAt(child,index);
			}
			checkAndPushElement(child);
			container.addChildAt(child,index);
			updateLayout();
			return child;
		}
		override  public function removeChild(child:DisplayObject, dispose:Boolean=false):DisplayObject
		{
			removeDisplay(child,dispose);
			updateLayout();
			return child;
		}
		override public function removeChildAt(index:int, dispose:Boolean=false):DisplayObject
		{
			if(removingBgAsset)
			{
				removingBgAsset = false;
				return super.removeChildAt(index,dispose);
			}
			var child:DisplayObject=container.removeChildAt(index,dispose);
			checkAndPopElement(child);
			updateLayout();
			return child;
		}
		override public function get width():Number
		{
			if(resized) return super.width;
			else return container.width;
		}
		override public function get height():Number
		{
			if(resized) return super.height;
			else return container.height;
		}
		override public function set width(value:Number):void
		{
			needRenderLayout=true;
			super.width=value;
		}
		
		override public function set height(value:Number):void
		{
			needRenderLayout=true;
			super.height=value;
		}
		
		override public function get numChildren():int
		{
			return container.numChildren;
		}
		protected function checkAndPushElement(child:DisplayObject):void
		{
			var element:ILayoutElement=child as ILayoutElement;
			if(!element)
			{
				return;
			}
			if(layoutElements.indexOf(element)!=-1)
			{
				return;
			}
			layoutElements.push(element);
		}
		protected function checkAndPopElement(child:DisplayObject):void
		{
			var element:ILayoutElement=child as ILayoutElement;
			if(!element)
			{
				return;
			}
			var idx:int=layoutElements.indexOf(element);
			if(idx!=-1)
			{
				layoutElements.splice(idx,1);
			}
		}
		override protected function renderUI():void
		{
			super.renderUI();
			renderLayout();
		}
		/**重绘时检测更新布局*/
		protected function renderLayout():void
		{
			if(!stage)return;
			if(width==UiConst.UI_MIN_SIZE||height==UiConst.UI_MIN_SIZE)return;
			if(needRenderLayout)
			{
				needRenderLayout=false;
				LUIManager.updateLayout(this);
			}
		}
		public function updateLayout():void
		{
			needRenderLayout=true;
			renderUI();
		}
		
		public function getContentBounds():Rectangle
		{
			return container.getBounds(this);
		}
		
		public function pack():void
		{
			setWH(container.width,container.height);
		}

		override public function dispose():void
		{
			removeAll();
			_layoutManager=null;
			_layoutElements=null;
			super.dispose();
		}
	}
}