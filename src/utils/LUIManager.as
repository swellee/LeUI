package utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import core.Idecorator;
	import core.IlayoutContainer;
	import core.IlayoutManager;
	import core.Istyle;
	import core.IstyleSheet;
	
	import events.LEvent;
	
	import vos.StyleVO;

	use namespace LeSpace;

	/**
	 * @author swellee
	 * 12-11-21
	 *
	 */
	public class LUIManager
	{
		private var stg:Stage;
		private var uiContanier:DisplayObjectContainer;
		private var styleSheet:IstyleSheet;
		private var _styleObserver:EventDispatcher;
		private var enterFrameFuns:Vector.<Function>=new Vector.<Function>();
		
		/**
		 *标准初始化 
		 * @param root  舞台
		 * @param uiContainer UI容器
		 * @param styleSheet 样式表
		 * @param SharedEventDispatcher UI组件共享的事件派发/监听对象
		 * 
		 */
		public static function initAsStandard(root:Stage,uiContainer:DisplayObjectContainer,
											  styleSheet:IstyleSheet,
											  SharedEventDispatcher:EventDispatcher=null):void
		{
			getInstance().stg=root;
			getInstance().stg.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			getInstance().uiContanier=uiContainer;
			
			setStyleSheet(styleSheet);
			styleObserver=SharedEventDispatcher;
		}
		/**
		 *设置样式表，设置新的样式表后，所有组件会重新渲染 
		 * @param styleSheet
		 * 
		 */
		public static function setStyleSheet(styleSheet:IstyleSheet):void
		{
			if(styleSheet!=getInstance().styleSheet)
			{
				getInstance().styleSheet=styleSheet;
				styleObserver.dispatchEvent(new LEvent(LEvent.STYLE_SHEET_CHANGED));
			}
		}
		protected static function onEnterFrame(event:Event):void
		{
			var funs:Vector.<Function>=getInstance().enterFrameFuns;
			for each (var fun:Function in funs)
			{
				fun.call(null,event);
			}
		}
		
		/**
		 *LexUI组件共用的事件派发器，UI组件均使用此对象 监听和派发事件
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
		 *集中处理帧频函数 
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
		 * 移除对帧频函数的监听
		 * @param fun
		 * 
		 */
		public static function removeEnterFrameListener(fun:Function):void
		{
			var idx:int=getInstance().enterFrameFuns.indexOf(fun);
			if(idx>-1)
			{
				getInstance().enterFrameFuns.splice(idx,1);
			}
		}
		/**
		 *更新样式 
		 * @param ui
		 * 
		 */
		LeSpace static function updateStyle(ui:Istyle):void
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
					LTrace.log('can not find StyleVO named-->"'+ui.style+'",the componet ' +ui.getDefaultStyleName()+
						'will resetStyle to default.');
					ui.resetStyle();
				}
				return;
			}
			var decorator:Idecorator=LPool.find(styleVo.decoratorClass)as Idecorator;
			decorator.decorate(ui,styleVo);
		}
		/**
		 *更新布局 
		 * @param ui 容器
		 * 
		 */		
		LeSpace static function updateLayout(ui:IlayoutContainer):void
		{
			var layoutManager:IlayoutManager=LPool.find(ui.getLayoutManager())as IlayoutManager;
			if(layoutManager)
			{
				layoutManager.doLayout(ui);
			}
		}
		/** 获取类名*/
		LeSpace static function getClassName(obj:*):String
		{
			var qName:String=getQualifiedClassName(obj);
			var idx:int=qName.lastIndexOf(":");
			if(idx>-1)
				return qName.substr(idx+1);
			return qName;
		}
		/**
		 *清除样式 此方法会resetStyle,之后从缓存池清理样式对应的装饰类实例 
		 * @param ui
		 * 
		 */
		public static function clearStyle(ui:Istyle):void
		{
			var styleVo:StyleVO=getInstance().styleSheet.getStyleVO(ui.style);
			var decorator:Idecorator=LPool.find(styleVo.decoratorClass)as Idecorator;
			LPool.pop(styleVo.decoratorClass);
			ui.resetStyle();
		}
		
	}
}