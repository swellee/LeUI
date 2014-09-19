package org.leui.utils
{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	
	import org.leui.core.IDecorator;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutManager;
	import org.leui.core.IStyle;
	import org.leui.core.IStyleSheet;
	import org.leui.events.LEvent;
	import org.leui.events.LStageEvent;
	import org.leui.vos.StyleVO;

	use namespace LeSpace;

	/**
	 *  LeUI大总管
	 * @author swellee
	 */
	public class LUIManager
	{
		private var stg:Stage;
		private var uiContanier:DisplayObjectContainer;
		private var styleSheet:IStyleSheet;
		private var _styleObserver:EventDispatcher;
		private var enterFrameFuns:Array=[];
		private var keyUpFuns:Array=[];
		private var keyDownFuns:Array=[];
		private var keyEnabled:Boolean = true;
		
		/**
		 *  标准初始化 
		 * @param root  舞台
		 * @param uiContainer UI容器
		 * @param styleSheet 样式表
		 * @param SharedEventDispatcher UI组件共享的事件派发/监听对象
		 * 
		 */
		public static function initAsStandard(root:Stage,uiContainer:DisplayObjectContainer,
											  styleSheet:IStyleSheet,
											  SharedEventDispatcher:EventDispatcher=null):void
		{
			getInstance().stg=root;
			getInstance().stg.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			getInstance().stg.addEventListener(MouseEvent.CLICK,onMouseClick);
			getInstance().stg.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			getInstance().stg.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			getInstance().uiContanier=uiContainer;
			
			setStyleSheet(styleSheet);
			styleObserver=SharedEventDispatcher;
			
			LTrace.init();
		}
		/**
		 *  设置样式表，设置新的样式表后，所有组件会重新渲染 
		 * @param styleSheet
		 * 
		 */
		public static function setStyleSheet(styleSheet:IStyleSheet):void
		{
			if(styleSheet!=getInstance().styleSheet)
			{
				getInstance().styleSheet=styleSheet;
				dispatchGlobalEvent(new LEvent(LEvent.STYLE_SHEET_CHANGED));
				LFactory.disposeAssetPool();
			}
		}
		
		/**
		 * IpopUp类弹窗的父容器 
		 * @return 
		 * 
		 */
		public static function get uiContainer():DisplayObjectContainer
		{
			return getInstance().uiContanier;
		}
		
		/**
		 *  派发全局事件 
		 * @param event
		 * 
		 */
		public static function dispatchGlobalEvent(event:Event):void
		{
			styleObserver.dispatchEvent(event);
		}
		/**
		 *  添加全局事件监听 
		 * @param eventType
		 * @param listenFun
		 * 
		 */
		public static function addGlobalEventListener(eventType:String, listenFun:Function):void
		{
			styleObserver.addEventListener(eventType,listenFun);
		}
		/**
		 *  移除全局事件监听 
		 * @param eventType
		 * @param listenFun
		 * 
		 */
		public static function removeGlobalEventListener(eventType:String, listenFun:Function):void
		{
			styleObserver.removeEventListener(eventType,listenFun);
		}
		
		/**
		 * 下一帧执行一次目标函数
		 * @param fun目标函数
		 * @param funPara目标函数的参数
		 * 
		 */
		public static function nextFrameCall(fun:Function,...funPara):void
		{
			addEnterFrameListener(function():void{fun.apply(null,funPara);removeEnterFrameListener(arguments.callee)});
		}

		/**
		 *   舞台 
		 * @return 
		 * 
		 */
		public static function get stage():Stage
		{
			return getInstance().stg;
		}
		protected static function onEnterFrame(event:Event):void
		{
			var funs:Array=getInstance().enterFrameFuns;
			for each (var fun:Function in funs)
			{
				fun.call(null,event);
			}
		}
		private static function onMouseClick(event:MouseEvent):void
		{
			var comp:DisplayObject=event.target as DisplayObject;
			if(comp) 	dispatchGlobalEvent(new LStageEvent(LStageEvent.STAGE_CLICK_EVENT,comp));
		}
		
		private static function onKeyUp(event:KeyboardEvent):void
		{
			if(!getInstance().keyEnabled)return;
			var funs:Array=getInstance().keyUpFuns;
			for each (var fun:Function in funs)
			{
				fun.call(null,event);
			}
		}
		
		private static function onKeyDown(event:KeyboardEvent):void
		{
			if(!getInstance().keyEnabled)return;
			var funs:Array=getInstance().keyDownFuns;
			for each (var fun:Function in funs)
			{
				fun.call(null,event);
			}
		}
		
		/**
		 *  LexUI组件共用的事件派发器，UI组件均使用此对象 监听和派发事件
		 * @param value
		 * 
		 */
		LeSpace static function get styleObserver():EventDispatcher
		{
			if(!getInstance()._styleObserver)
				getInstance()._styleObserver=LPool.find(EventDispatcher)as EventDispatcher;
			return getInstance()._styleObserver;
		}
		LeSpace static function set styleObserver(value:EventDispatcher):void
		{
			getInstance()._styleObserver = value;
		}
		
		private static function getInstance():LUIManager
		{
			return LPool.find(LUIManager) as LUIManager;
		}
	
		/**
		 *  集中处理帧频函数 
		 * @param fun 函数，需以事件类型为参数
		 * </br>eg:  function aaa(e:Event):void{}
		 */		
		public static function addEnterFrameListener(fun:Function):void
		{
			if(getInstance().enterFrameFuns.indexOf(fun)==-1)
			{
				getInstance().enterFrameFuns.push(fun);
			}
		}
		
		/**
		 *   移除对帧频函数的监听
		 * @param fun
		 * 
		 */
		public static function removeEnterFrameListener(fun:Function):void
		{
			var funs:Array = getInstance().enterFrameFuns; 
			var idx:int=funs.indexOf(fun);
			if(idx>-1)
			{
				funs.splice(idx,1);
			}
		}
		
		/**
		 *  设置键盘监听是否生效 
		 * @param val
		 * 
		 */
		public static function setKeyEnable(val:Boolean):void
		{
			getInstance().keyEnabled = val;
		}
		
		/**
		 *  添加键盘事件（KEY_UP）监听
		 * @param fun 函数，需以键盘事件类型为参数
		 * </br>eg:  function aaa(e:KeyboardEvent):void{}
		 */
		public static function addKeyUpListener(fun:Function):void
		{
			if(getInstance().keyUpFuns.indexOf(fun)==-1)
			{
				getInstance().keyUpFuns.push(fun);
			}
		}
		
		/**
		 *  添加键盘事件（KEY_DOWN）监听
		 * @param fun 函数，需以键盘事件类型为参数
		 * </br>eg:  function aaa(e:KeyboardEvent):void{}
		 */
		public static function addKeyDownListener(fun:Function):void
		{
			if(getInstance().keyDownFuns.indexOf(fun)==-1)
			{
				getInstance().keyDownFuns.push(fun);
			}
		}
		/**
		 *   移除键盘事件监听
		 * @param fun
		 * 
		 */
		public static function removeKeyUpListener(fun:Function):void
		{
			var idx:int=getInstance().keyUpFuns.indexOf(fun);
			if(idx>-1)
			{
				getInstance().keyUpFuns.splice(idx,1);
			}
		}
		
		/**
		 *   移除键盘事件监听
		 * @param fun
		 * 
		 */
		public static function removeKeyDownListener(fun:Function):void
		{
			var idx:int=getInstance().keyDownFuns.indexOf(fun);
			if(idx>-1)
			{
				getInstance().keyDownFuns.splice(idx,1);
			}
		}
		
		/**
		 *  更新样式 
		 * @param ui
		 * 
		 */
		LeSpace static function updateStyle(ui:IStyle):void
		{
			var styleVo:StyleVO=getInstance().styleSheet.getStyleVO(ui.style);
			if(!styleVo)
			{
				if(ui.style.charAt(0)=="L")//default 
				{
					LTrace.warnning('had not config-->"'+ui.style+'" in styleSheet, the related ui may not display correctly!');
				}
				else
				{
					LTrace.log('can not find StyleVO named-->"'+ui.style+'",the componet ' +ui.getDefaultStyle()+
						'will resetStyle to default.');
					ui.resetStyle();
				}
				return;
			}
			var decorator:IDecorator=LPool.find(styleVo.decoratorClass)as IDecorator;
			decorator.decorate(ui,styleVo);
		}
		/**
		 *  更新布局 
		 * @param ui 容器
		 * 
		 */		
		LeSpace static function updateLayout(ui:ILayoutContainer):void
		{
			var layoutManager:ILayoutManager=LPool.find(ui.getLayoutManager())as ILayoutManager;
			if(layoutManager)
			{
				layoutManager.doLayout(ui);
			}
		}
		/**   获取类名*/
		public static function getClassName(obj:*):String
		{
			var qName:String=getQualifiedClassName(obj);
			var idx:int=qName.lastIndexOf(":");
			if(idx>-1)
				return qName.substr(idx+1);
			return qName;
		}
		/**
		 *  清除样式 此方法会resetStyle,之后从缓存池清理样式对应的装饰类实例 
		 * @param ui
		 * 
		 */
		public static function clearStyle(ui:IStyle):void
		{
			var styleVo:StyleVO=getInstance().styleSheet.getStyleVO(ui.style);
			var decorator:IDecorator=LPool.find(styleVo.decoratorClass)as IDecorator;
			LPool.pop(styleVo.decoratorClass);
			ui.resetStyle();
		}
		
		/**
		 *  在指定容器中查找符合给定属性值的子显示对象 
		 * @param container 指定容器
		 * @param keyAndValue 键值对，用于表示要匹配的属性名及值
		 * @param subChild 该容器的某一子级对象，从此对象上溯查找直到容器本身
		 * @return 
		 * 
		 */
		public static function findChildByProperty(container:DisplayObjectContainer,keyAndValue:Object,subChild:DisplayObject):*
		{
			if(container==subChild)return null;   
			var hasKey:Boolean=false;
			var flag:Boolean=true;
			var obj:DisplayObject=null;
			for (var key:String in keyAndValue) 
			{
				if(subChild.hasOwnProperty(key))
				{
					hasKey=true;
					if(subChild[key]!=keyAndValue[key])
					{
						flag=false;
					}
				}
			}
			
			if(hasKey&&flag)
			{
				obj=subChild;
			}
			else if(subChild.parent)
			{
				obj=findChildByProperty(container,keyAndValue,subChild.parent);
			}
			
			return obj;
		}
	}
}