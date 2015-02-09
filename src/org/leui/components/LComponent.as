package org.leui.components
{
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import org.leui.core.IComponent;
	import org.leui.core.InnerContainer;
	import org.leui.core.LSprite;
	import org.leui.events.LEvent;
	import org.leui.events.LStageEvent;
	import org.leui.events.MouseEvent;
	import org.leui.utils.LFactory;
	import org.leui.utils.LFilters;
	import org.leui.utils.LUIManager;
	import org.leui.utils.LeSpace;
	import org.leui.utils.UiConst;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
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
		private var bgImg:Image;
		private var needRenderBg:Boolean;
		private var _width:int=UiConst.UI_MIN_SIZE;
		private var _height:int=UiConst.UI_MIN_SIZE;
		private var _enable:Boolean=true;
		private var _selected:Boolean;
		private var _canScaleX:Boolean=true;
		private var _canScaleY:Boolean=true;
		private var _data:*;
		protected var disposed:Boolean;
		private var msLoc:Point;
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
		private var lastTouchPhase:String;
		private var lastTouchStmp:int;//上次touch事件时间点
		private var lastClickStmp:int;//上次CLICK事件时间点
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
			addEventListener(TouchEvent.TOUCH,onTounch);
			addGlobalEventListener(LEvent.STYLE_SHEET_CHANGED,onStyleSheetChange);
			addGlobalEventListener(LStageEvent.STAGE_HOVER_CHANGE_EVENT,onStgHoverChange);
		}
		/**
		 *  销毁时调用，用于移除事件监听 
		 * 
		 */		
		protected function removeEvents():void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onDeactive);
			removeEventListener(TouchEvent.TOUCH,onTounch);
			removeGlobalEventListener(LEvent.STYLE_SHEET_CHANGED,onStyleSheetChange);
			removeGlobalEventListener(LStageEvent.STAGE_HOVER_CHANGE_EVENT,onStgHoverChange);
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
		
		//下面这两个方法，用以模拟被starling干掉的部分MouseEvent------------------------
		private function onTounch(evt:TouchEvent):void
		{
			evt.stopImmediatePropagation();
			var touch:Touch = evt.getTouch(this);
			if(touch)
			{
				var msEvtType:String;
				switch(touch.phase)
				{
					case TouchPhase.HOVER:
						msEvtType = MouseEvent.ROLL_OVER;
						break;
					case TouchPhase.BEGAN:
						msEvtType = MouseEvent.MOUSE_DOWN;
						break;
					case TouchPhase.ENDED:
						msEvtType = MouseEvent.MOUSE_UP;
						break;
				}
				if(msEvtType)
				{
					dispatchEvent(new MouseEvent(msEvtType));//先不冒泡
				}
				//判断是否需要触发一次CLICK事件
				var now:int = getTimer();
				if(lastTouchPhase == TouchPhase.BEGAN
					&& touch.phase == TouchPhase.ENDED
					&& now-lastTouchStmp <600)
				{
					msEvtType = MouseEvent.CLICK;
					dispatchEvent(new MouseEvent(msEvtType));
					
					//判断是否需要触发一次DOUBLE_CLICK
					if(lastClickStmp>0
						&& now - lastClickStmp<800)
					{
						msEvtType = MouseEvent.DOUBLE_CLICK;
						dispatchEvent(new MouseEvent(msEvtType));
					}
					lastClickStmp = now;
				}
				lastTouchPhase = touch.phase;
				lastTouchStmp = now;
			}
		}
		private function onStgHoverChange(evt:LStageEvent):void
		{
			this.globalToLocal(LUIManager.mouseStagePosition,msLoc);
			if(evt.mouseTarget != this)
			{
				this.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));//先不冒泡
			}
		}
		///-----------------------------------------------------------------------------
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
			if(_enable == value)return;
			_enable = value;
			LFilters.setEnableFilter(this);
			value?onActive(null):onDeactive(null);
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
		
		public function get mouseX():Number
		{
			return msLoc.x;
		}
		public function get mouseY():Number
		{
			return msLoc.y;
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
			renderUI();
		}
		
		/**舞台重绘处理函数，可在此函数中执行样式变更*/
		protected function renderUI():void
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
		
		override public function get bounds():Rectangle
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
			if(bgImg&&contains(bgImg))
			{
				removeChild(bgImg);
				bgImg = null;
			}
		}
		public function setBg(asset:DisplayObject):void
		{
			needRenderBg=true;
			if(bgAsset != asset)
			{
				clearBg();
			}
			bgAsset=asset;
			renderUI();
		}
		
		/**
		 * 将背景资源绘制到img上（使用九宫格） 
		 */
		private function drawBg():void
		{
			var s:Sprite = new Sprite();
			s.addChild(bgAsset);
			bgAsset.width = _width;
			bgAsset.height = _height;
			var bmd:BitmapData = new BitmapData(_width,_height,true,0);
			bmd.draw(s);
			if(!bgImg)
			{
				bgImg = new Image(Texture.fromBitmapData(bmd));
				addChildAt(bgImg,0);
			}
			else
			{
				bgImg.texture = Texture.fromBitmapData(bmd);
			}
		}
		
		/**重绘时检测更新背景*/
		private function renderBg():void
		{
			if(needRenderBg)
			{
				needRenderBg=false;
				if(bgAsset)
				{
					drawBg();
				}
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
				this.clipRect=_contentMask;
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
			renderUI();
		}
		override public function set height(value:Number):void
		{
			value=value>UiConst.UI_MIN_SIZE?value:UiConst.UI_MIN_SIZE;
			if(value==_height)return;
			
			_height=value;
			resized=true;
			needRenderBg=true;
			renderUI();
		}
		/**重置遮罩尺寸*/
		protected function resizeMask():void
		{
			contentMask.width=width;
			contentMask.height=height;
			this.clipRect=contentMask;
		}
		
		public function get data():*
		{
			return _data;
		}
		public function set data(val:*):void
		{
			_data=val;
		}
		/**
		 *  背景是否为空 （这个属性主要给编辑器用） 
		 * @return 
		 * 
		 */
		LeSpace function isBlankBg():Boolean
		{
			return bgAsset == null;
		}
		override public function dispose():void
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
//			LFactory.disposeDisplayObj(this);
			_data=null;
			_contentMask=null;
			bgImg = null;
			super.dispose();
			disposed=true;
		}
	}
}