package org.leui.utils
{
	import org.leui.components.LButton;
	import org.leui.components.LScrollPane;
	import org.leui.components.LTextArea;
	import org.leui.components.LWindow;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	
	/**
	 *  日志弹窗
	 *@author swellee
	 */
	internal class LTraceWindow extends LWindow
	{
		private var infoTxt:LTextArea;
		private const MY_WIDTH:int=460;
		private const MY_HEIGHT:int=380;

		private var scP:LScrollPane;
		private var copyBtn:LButton;
		private var clearBtn:LButton;
		public function LTraceWindow()
		{
			super("LeUI_Trace_Info");
			setWH(MY_WIDTH,MY_HEIGHT);
		}
		
		override protected function initElements():void
		{
			super.initElements();
			addComps();
		}
		private function addComps():void
		{
			infoTxt=new LTextArea();
			infoTxt.textField.type=TextFieldType.DYNAMIC;
			scP=new LScrollPane(infoTxt);
			
			copyBtn=new LButton("Copy");
			clearBtn=new LButton("Clear");
			copyBtn.setWH(60,28);
			clearBtn.setWH(60,28);
			
			addContent(scP,copyBtn,clearBtn);
		}
		
		override protected function addEvents():void
		{
			super.addEvents();
			copyBtn.addEventListener(MouseEvent.CLICK,onCopy);
			clearBtn.addEventListener(MouseEvent.CLICK,onClear);
		}
		
		protected function onClear(event:MouseEvent):void
		{
			infoTxt.text="";
			LTrace.clear();
		}
		
		protected function onCopy(event:MouseEvent):void
		{
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,infoTxt.text);
			LTrace.log("woierowo\n");
		}
		
		public function appendLog(str:String):void
		{
			infoTxt.appendText(str);
		}
		
		override public function getDefaultStyle():String
		{
			return "LWindow";
		}
		
		override public function updateLayout():void
		{
			super.updateLayout();
			
			if(scP)
			{
				scP.setWH(ele_content_pane.width-2,ele_content_pane.height-30);
				copyBtn.setXY(100,ele_content_pane.height-29);
				clearBtn.setXY(ele_content_pane.width-160,ele_content_pane.height-29);
			}
		}
	}
}