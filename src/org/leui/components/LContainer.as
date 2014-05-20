package org.leui.components
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.leui.core.IDispose;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutElement;
	import org.leui.core.InnerContainer;
	import org.leui.layouts.BasicLayout;
	import org.leui.utils.LUIManager;
	import org.leui.utils.LeSpace;
	import org.leui.utils.UiConst;

	use namespace LeSpace
	
	/**
	 *@author swellee
	 *2013-4-6
	 *容器,定义了作为容器的基本方法。
	 *</br>推荐使用其功能封装更全面的子类，如LPane、LBox、LList、LGrid等
	 */
	public class LContainer extends LComponent implements ILayoutContainer
	{
		protected var _layoutElements:Vector.<ILayoutElement>;
		protected var _layoutManager:Class;
		private var needRenderLayout:Boolean;
		/**显示对象的真正容器*/
		protected var container:InnerContainer;
		/**
		 *容器 
		 */
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
				container.scrollRect=null;
				super.addChild(container);
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
		public function remove(child:DisplayObject,dispose:Boolean=true):DisplayObject
		{
			checkAndPopElement(child);
			if(container.contains(child))	container.removeChild(child);
			if(dispose&&(child is IDispose))
			{
				(child as IDispose).dispose();
			}
			updateLayout();
			return child;
		}
		public function removeAll(dispose:Boolean=true):void
		{
			while(layoutElements.length>0)
			{
				var ele:ILayoutElement=layoutElements[0] ;
				remove(ele as DisplayObject);
				if(ele&&dispose)
				{
					ele.dispose();
				}
			}
		}
		public function append(child:DisplayObject, layoutImmediately:Boolean=true):void
		{
			checkAndPushElement(child);
			if(layoutImmediately)
			{
				updateLayout();
			}
			container.addChild(child);
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
			append(child);
			return child;
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			checkAndPushElement(child);
			container.addChildAt(child,index);
			updateLayout();
			return child;
		}
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			return remove(child);
		}
		override public function  removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject=container.removeChildAt(index);
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
		override protected function render():void
		{
			super.render();
			renderLayout();
		}
		/**重绘时检测更新布局*/
		private function renderLayout():void
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
			render();
		}
		
		public function getContentBounds():Rectangle
		{
			return container.getBounds(this);
		}
		
		public function pack():void
		{
			width=container.width;
			height=container.height;
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