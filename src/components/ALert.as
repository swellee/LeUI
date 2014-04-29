package components
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import utils.UiConst;
	
	
	/**
	 *信息提示弹窗
	 *2014-4-27
	 *@author swellee
	 */
	public class ALert extends LWindow
	{
		private var msgTxt:LTextArea;

		private var closeCallFun:Function;
		private var closeCallParas:Array=[];
		
		public static const OK:int=0x01;
		public static const CANCEL:int=0x02;
		public static const YES:int=0x04;
		public static const NO:int=0x08;
		
		public static var OK_STR:String="Ok";
		public static var CANCEL_STR:String="Cancel";
		public static var YES_STR:String="Yes";
		public static var NO_STR:String="No";
		
		/**
		 *需要显示的按钮 仅于布局时取用
		 */
		private var btns:Array;
		
		/**
		 * 
		 * @param title 标题
		 * @param msg 消息内容
		 * @param btns 要显示的按钮，使用常量ALert.OK、ALert.CANCEL、ALert.YES、ALert.NO，要显示多个按钮，可使用 “位与”操作符（|）联结多个常量。如ALert.OK|ALert.CANCEL
		 * @param autoDisposeOnClose 关闭时是否自动销毁
		 * @param canDrag 是否可拖动
		 * @param closeCallback 关闭时的回调函数，该函数第一个参数必须为int型，代表关闭时所点击的按钮常量（可能值为：0、ALert.OK、ALert.CANCEL、ALert.YES、ALert.NO）
		 * @param callbackParamData 回调函数附带的第二个参数。
		 * 
		 * </br>推荐使用静态函数show()来创建和显示ALert
		 * @see ALert.show()
		 */
		public function ALert(title:String=null,msg:String=null,btns:int=ALert.OK, autoDisposeOnClose:Boolean=true,canDrag:Boolean=true,closeCallback:Function=null,callbackParamData:*=null)
		{
			super(title,autoDisposeOnClose,canDrag);
			if(msg)setMessage(msg);
			setButtons(btns);
			ele_close_btn.data=0;
			this.closeCallFun=closeCallback;
			this.closeCallParas.push(callbackParamData);
		}
		
		public function setMessage(msg:String):void
		{
			if(!msgTxt)
			{
				msgTxt=new LTextArea("",false);
				//use textfield center algin
				var txt:TextField=msgTxt.textField;
				var tf:TextFormat=txt.defaultTextFormat;
				tf.align=TextFormatAlign.CENTER;
				txt.defaultTextFormat=tf;
				
				msgTxt.setXY(UiConst.WINDOW_BORDER_SIZE,UiConst.WINDOW_BORDER_SIZE);
				ele_content_pane.append(msgTxt);
			}
			if(msg)
			{
				msgTxt.text=msg;
			}
		}
		
		private function setButtons(btn:int=ALert.OK):void
		{
			btns=[];
			if((btn&OK)==OK)
			{
				var btnObj:LButton=new LButton(OK_STR);
				btnObj.data=OK;
				btnObj.setWH(UiConst.ALERT_BUTTON_WIDTH,UiConst.ALERT_BUTTON_HEIGHT);
				btnObj.addEventListener(MouseEvent.CLICK,onCloseHandler);
				btns.push(btnObj);
			}
			if((btn&CANCEL)==CANCEL)
			{
				btnObj=new LButton(CANCEL_STR);
				btnObj.data=CANCEL;
				btnObj.setWH(UiConst.ALERT_BUTTON_WIDTH,UiConst.ALERT_BUTTON_HEIGHT);
				btnObj.addEventListener(MouseEvent.CLICK,onCloseHandler);
				btns.push(btnObj);
			}
			if((btn&YES)==YES)
			{
				btnObj=new LButton(YES_STR);
				btnObj.data=YES;
				btnObj.setWH(UiConst.ALERT_BUTTON_WIDTH,UiConst.ALERT_BUTTON_HEIGHT);
				btnObj.addEventListener(MouseEvent.CLICK,onCloseHandler);
				btns.push(btnObj);
			}
			if((btn&NO)==NO)
			{
				btnObj=new LButton(NO_STR);
				btnObj.data=NO;
				btnObj.setWH(UiConst.ALERT_BUTTON_WIDTH,UiConst.ALERT_BUTTON_HEIGHT);
				btnObj.addEventListener(MouseEvent.CLICK,onCloseHandler);
				btns.push(btnObj);
			}
			
			if(btns.length)
			{
				addContent.apply(null,btns);
			}
		}
		
		override protected function onCloseHandler(event:MouseEvent):void
		{
			if(closeCallFun!=null)
			{
				//第一个参数为点击的按钮索引
				closeCallParas.unshift(event.currentTarget.data);
				closeCallFun.apply(null,closeCallParas);
			}
			super.onCloseHandler(event);
		}
		override public function updateLayout():void
		{
			super.updateLayout();
			//将内容文本尺寸合适到内容面板
			if(msgTxt)
			{
				msgTxt.setWH(ele_content_pane.width-UiConst.WINDOW_BORDER_SIZE*2,
					ele_content_pane.height-UiConst.WINDOW_BORDER_SIZE*2);
			}
			
			if(btns&&btns.length)
			{
				var margin:int=ele_content_pane.width-UiConst.ALERT_BUTTON_WIDTH*btns.length;
				margin/=btns.length+1;
				for (var i:int = 0; i < btns.length; i++) 
				{
					var btn:LButton=btns[i];
					btn.setXY(margin+(margin+UiConst.ALERT_BUTTON_WIDTH)*i,ele_content_pane.height-UiConst.ALERT_BUTTON_BODER_MARGIN-UiConst.ALERT_BUTTON_HEIGHT);
				}
				
			}
		}
		
		override public function dispose():void
		{
			closeCallFun=null;
			closeCallParas=null;
			super.dispose();
		}
		
		/**
		 *弹出一个消息提示框 （ALert） 
		 * @param title 标题
		 * @param msg 消息内容
		 * @param btns 要显示的按钮，使用常量ALert.OK、ALert.CANCEL、ALert.YES、ALert.NO，要显示多个按钮，可使用 “位与”操作符（|）联结多个常量。如ALert.OK|ALert.CANCEL
		 * @param autoDisposeOnClose 关闭时是否自动销毁
		 * @param canDrag 是否可拖动
		 * @param closeCallback 关闭时的回调函数，该函数第一个参数必须为int型，代表关闭时所点击的按钮常量（可能值为：0、ALert.OK、ALert.CANCEL、ALert.YES、ALert.NO）
		 * @param callbackParamData 回调函数附带的第二个参数。
		 * @param contentsToAdd 要添加到内容面板上的显示对象数组
		 * @param contentsPostiion  要添加到内容面板上的显示对象对应的坐标
		 * @return 弹出的ALert实例
		 * 
		 */
		public static function show(title:String=null,msg:String=null,btns:int=ALert.OK, 
									autoDisposeOnClose:Boolean=true,canDrag:Boolean=true,
									closeCallback:Function=null,callbackParamData:*=null,
									contentsToAdd:Array=null,contentsPostiion:Vector.<Point>=null):ALert
		{
			var alert:ALert=new ALert(title,msg,btns,autoDisposeOnClose,canDrag,closeCallback,callbackParamData);
			if(contentsToAdd)
			{
				for (var i:int = 0; i < contentsToAdd.length; i++) 
				{
					var obj:DisplayObject = contentsToAdd[i];
					obj.x=contentsPostiion[i].x;
					obj.y=contentsPostiion[i].y;
				}
				alert.addContent.apply(null,contentsToAdd);
			}
			alert.setWH(UiConst.ALERT_INIT_WIDTH,UiConst.ALERT_INIT_HEIGHT);
			alert.show();
			return alert;
		}
	}
}