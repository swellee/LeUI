package components
{
	import core.IDispose;
	import core.IlayoutContainer;
	import core.IlayoutElement;
	import core.LSprite;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import layouts.BasicLayout;
	
	import utils.LUIManager;
	import utils.LeSpace;

	use namespace LeSpace
	
	/**
	 *@author swellee
	 *2013-4-6
	 *容器,定义了作为容器的基本方法。
	 *</br>推荐使用其功能封装更全面的子类，如LPane、LBox、LList、LGrid等
	 */
	public class LContainer extends LComponent implements IlayoutContainer
	{
		protected var _layoutElements:Vector.<IlayoutElement>;
		protected var _layoutManager:Class;
		private var needRenderLayout:Boolean;
		/**显示对象的真正容器*/
		protected var view:LSprite;
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
			if(!view)
			{
				view=new LSprite();
				view.scrollRect=null;
				super.addChild(view);
			}
		}
		override protected function onActive(event:Event):void
		{
			super.onActive(event);
			updateLayout();
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
		
		public function get layoutElements():Vector.<IlayoutElement>
		{
			return _layoutElements||=new Vector.<IlayoutElement>();
		}
		public function remove(child:DisplayObject,dispose:Boolean=true):DisplayObject
		{
			checkAndPopElement(child);
			if(view.contains(child))	view.removeChild(child);
			if(dispose&&(child is IDispose))
			{
				(child as IDispose).dispose();
			}
			return child;
		}
		public function removeAll(dispose:Boolean=true):void
		{
			while(layoutElements.length>0)
			{
				var ele:IlayoutElement=layoutElements[0] ;
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
			view.addChild(child);
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
			view.addChildAt(child,index);
			updateLayout();
			return child;
		}
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			return remove(child);
		}
		override public function  removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject=view.removeChildAt(index);
			checkAndPopElement(child);
			return child;
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
		private function checkAndPushElement(child:DisplayObject):void
		{
			var element:IlayoutElement=child as IlayoutElement;
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
		private function checkAndPopElement(child:DisplayObject):void
		{
			var element:IlayoutElement=child as IlayoutElement;
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
			if(needRenderLayout)
			{
				needRenderLayout=false;
				LUIManager.updateLayout(this);
			}
		}
		public function updateLayout():void
		{
			if(!stage)return;
			needRenderLayout=true;
			render();
		}
		
		public function getContentBounds():Rectangle
		{
			var rec:Rectangle;
			var i:int=view.numChildren;
			while(--i>-1)
			{
				var child:DisplayObject=view.getChildAt(i);
				var childRect:Rectangle=child.getBounds(this);
				rec=rec?rec.union(childRect):childRect;
			}
			return rec||=new Rectangle();
		}
		
		public function pack():void
		{
			var rec:Rectangle=getContentBounds();
			width=rec.width;
			height=rec.height;
		}

		override public function dispose():void
		{
			_layoutManager=null;
			_layoutElements=null;
			super.dispose();
		}
	}
}