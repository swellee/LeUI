package org.leui.components
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.leui.core.IComponent;
	import org.leui.core.InnerContainer;
	import org.leui.core.LSprite;
	import org.leui.events.LEvent;
	import org.leui.utils.LFactory;
	import org.leui.utils.LFilters;
	import org.leui.utils.LUIManager;
	import org.leui.utils.LeSpace;
	import org.leui.utils.UiConst;
	
	use namespace LeSpace;
	/**
	 *   LeUI组件基类
	 *@author swellee
	 */
	public class LComponent extends LSprite implements IComponent
	{
		private var _styleName:String;
		private var _contentMask:Rectangle;
		private var bgAsset:DisplayObject;
		private var needRenderBg:Boolean;
		private var _width:int=UiConst.UI_MIN_SIZE;
		private var _height:int=UiConst.UI_MIN_SIZE;
		private var _enable:Boolean=true;
		private var _selected:Boolean;
		private var _canScaleX:Boolean=true;
		private var _canScaleY:Boolean=true;
		private var _data:*;
		protected var disposed:Boolean;
		/**
		 *  是否改变过尺寸 
		 */
		protected var resized:Boolean;
		/**
		 *  是否正在添加bg图（因为LContainer覆写了addChildAt()方法，为保证bg的正确呈现，加此标识） 
		 */		
		protected var addingBgAsset:Boolean;
		/**
		 *  是否正在移除bg图（因为LContainer覆写了removeChildAt()方法，为保证bg的正确移除，加此标识） 
		 */		
		protected var removingBgAsset:Boolean;
		public function LComponent()
		{
			super();
			init();
			addEventListener(Event.ADDED_TO_STAGE,onActive);
		}
		
		/**  初次被添加到显示列表时，激活*/
		protected function onActive(event:Event):void
		{
			addEvents();
			//作为复杂组件的元素时，当被添加到显示列表时，不再执行更新样式，因为组件对象会对子元素在适当的时候执行更新
			if(!isCompElement)
			{
				updateStyle();
			}
		}
		
		/**
		 *  组件被激活时调用，用于初始化，子类重写 
		 * 
		 */		
		protected function init():void
		{
		}
		/**
		 *  构造函数中调用，用于添加交互事件监听 
		 * 
		 */		
		protected function addEvents():void
		{
			addEventListener(Event.REMOVED_FROM_STAGE,onDeactive);
			addGlobalEventListener(LEvent.STYLE_SHEET_CHANGED,onStyleSheetChange);
		}
		/**
		 *  销毁时调用，用于移除事件监听 
		 * 
		 */		
		protected function removeEvents():void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onDeactive);
			removeGlobalEventListener(LEvent.STYLE_SHEET_CHANGED,onStyleSheetChange);
		}
		/**  当被移出显示列表时，停止所有事件侦听*/
		protected function onDeactive(event:Event):void
		{
			removeEvents();
			addEventListener(Event.ADDED_TO_STAGE,onActive);
		}
		
		/**  样式表变化时，更新样式*/
		private function onStyleSheetChange(evt:LEvent):void
		{
			updateStyle();
		}
		
		public function getDefaultStyle():String
		{
			return LUIManager.getClassName(this);
		}
		public function get enabled():Boolean
		{
			return _enable;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enable = value;
			LFilters.setEnableFilter(this);
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(value:Boolean):void
		{
			_selected=value;
		}
		public function get isListCell():Boolean
		{
			if(parent&&parent is InnerContainer)
				return(parent as InnerContainer).isListContainer;
			return false;
		}
		/**
		 * 是否为复杂组件的元素对象 ，如果为true，则onActive方法中将不再自动更新样式或布局，而是由父组件在适当时候执行该子元素的更新
		 */
		protected function get isCompElement():Boolean
		{
			if(parent)
			{
				if(parent is InnerContainer)
					return (parent as InnerContainer).isCombineContainer;
				else if(parent is LMultiState)
					return true;
			}
			return false;
		}
		public function setXY(x:int, y:int):void
		{
			this.x=x;
			this.y=y;
		}
		
		public function setWH(width:int=-1,height:int=-1):void
		{
			if(width!=-1)
				this.width=width;
			if(height!=-1)
				this.height=height;
		}
		
		public function dispatchGlobalEvent(event:Event):void
		{
			LUIManager.dispatchGlobalEvent(event);
		}
		
		public function addGlobalEventListener(eventType:String, listenFun:Function):void
		{
			LUIManager.addGlobalEventListener(eventType,listenFun);
		}
		
		public function removeGlobalEventListener(eventType:String, listenFun:Function):void
		{
			LUIManager.removeGlobalEventListener(eventType,listenFun);
		}
		
		public function get style():String
		{
			return _styleName||=getDefaultStyle();
		}
		
		public function set style(value:String):void
		{
			value=value||getDefaultStyle();
			if(_styleName!=value)
			{
				_styleName=value;
				updateStyle();
			}
		}
		private function onRenderHandler(evt:LEvent):void
		{
			if(!stage)return;
			render();
		}
		
		/**舞台重绘处理函数，可在此函数中执行样式变更*/
		protected function render():void
		{
			renderBg();
		}
		/**更新样式*/
		private function updateStyle():void
		{
			if(!stage)return;
			LUIManager.updateStyle(this);
		}
		public function resetStyle():void
		{
			style=getDefaultStyle();
		}
		
		public function get bounds():Rectangle
		{
			return new Rectangle(x,y,width,height);
		}
		
		public function get canScaleX():Boolean
		{
			return _canScaleX;
		}
		
		public function set canScaleX(value:Boolean):void
		{
			_canScaleX=value;
		}
		
		public function get canScaleY():Boolean
		{
			return _canScaleY;
		}
		
		public function set canScaleY(value:Boolean):void
		{
			_canScaleY=value;
		}
		
		public function clearBg():void
		{
			if(bgAsset&&contains(bgAsset))
			{
				removeChild(bgAsset);
			}
		}
		public function setBg(asset:DisplayObject):void
		{
			if(!bgAsset)// 首次调用此方法
			{
				addingBgAsset = true;
				addChildAt(asset,0);
				asset.width=_width;
				asset.height=_height;
				resizeMask();
				bgAsset=asset;
			}
			else
			{
				needRenderBg=true;
				bgAsset=asset;
				render();
			}
		}
		/**重置背景图尺寸*/
		private function resizeBgAsset():void
		{
			if(bgAsset)
			{
				removingBgAsset = true;
				removeChildAt(0);
				addingBgAsset = true;
				addChildAt(bgAsset,0);
				bgAsset.width=_width;
				bgAsset.height=_height;
			}
		}

		/**重绘时检测更新背景*/
		private function renderBg():void
		{
			if(needRenderBg)
			{
				needRenderBg=false;
				resizeBgAsset();
				resizeMask();
			}
		}
		/**
		 * 组件遮罩矩形
		 * 
		 */		
		protected function get contentMask():Rectangle
		{
			if(!_contentMask)
			{
				_contentMask=new Rectangle(0,0,width,height);
				this.scrollRect=_contentMask;
			}
			return _contentMask;
		}
		
		//重写宽高getter setter
		override public function get width():Number
		{
			return _width;
		}
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set width(value:Number):void
		{
			value=value>UiConst.UI_MIN_SIZE?value:UiConst.UI_MIN_SIZE;
			if(value==_width)return;
			
			_width=value;
			resized=true;
			needRenderBg=true;
			render();
		}
		override public function set height(value:Number):void
		{
			value=value>UiConst.UI_MIN_SIZE?value:UiConst.UI_MIN_SIZE;
			if(value==_height)return;
			
			_height=value;
			resized=true;
			needRenderBg=true;
			render();
		}
		/**重置遮罩尺寸*/
		protected function resizeMask():void
		{
			contentMask.width=width;
			contentMask.height=height;
			this.scrollRect=contentMask;
		}
		
		public function get data():*
		{
			return _data;
		}
		public function set data(val:*):void
		{
			_data=val;
		}
		
		public function dispose():void
		{
			if(disposed)return;
			removeEvents();
			removeEventListener(Event.ADDED_TO_STAGE,onActive);
			if(bgAsset)
			{
				removingBgAsset = true;
				removeChildAt(0);
				LFactory.putDisplayObj(bgAsset);
				bgAsset = null;
			}
			LFactory.disposeDisplayObj(this);
			_data=null;
			_contentMask=null;
			disposed=true;
		}
	}
}