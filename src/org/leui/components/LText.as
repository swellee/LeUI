package org.leui.components
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import org.leui.events.LStageEvent;
	import org.leui.events.MouseEvent;
	import org.leui.utils.LGeom;
	import org.leui.utils.LUIManager;
	import org.leui.utils.UiConst;
	
	import starling.display.Image;
	import starling.textures.Texture;
	

	/**
	 *  文本组件
	 *@author swellee
	 */
	public class LText extends LComponent
	{
		private var _textfield:TextField;
		private var _editable:Boolean;
		private var _viewBounds:Rectangle;
		private var _viewportMask:Shape;
		/**
		 *文字与外框边距 
		 */
		protected static const textFrameSpace:Number=4;
		protected static const textHelper:TextField = new TextField();
		protected static const locHelper:Point = new Point();
		protected var textHelpeMe:Boolean;
		private var textOffX:int;
		private var textOffY:int;
		private var textAlign:int;
		private var textBmd:BitmapData;
		private var textImg:Image;
		public function LText(text:String="",editable:Boolean=true)
		{
			super();
			this.text=text;
			this.editable=editable;
			this.touchGroup = true;
			width=UiConst.TEXT_DEFAULT_WIDTH;
			height=UiConst.TEXT_DEFAULT_HEIGHT;
			textAlign = UiConst.TEXT_ALIGN_MIDDLE_CENTER;
		}

		/**
		 *  设置文本内容的布局 
		 * @param textAlign 可用值为：UiConst.TEXT_ALIGN_TOP_LEFT，UiConst.TEXT_ALIGN_TOP_CENTER……。
		 * @param offX 偏移X
		 * @param offY 偏移Y
		 * 
		 */
		public function setAlign(textAlign:int,offX:int=0,offY:int=0):void
		{
			this.textAlign=textAlign;
			this.textOffX=offX;
			this.textOffY=offY;
			updateAlign();
		}
		
		public function get format():TextFormat
		{
			return textField.defaultTextFormat;
		}

		public function set format(value:TextFormat):void
		{
			textField.defaultTextFormat = value;
			textField.text=textField.text;
		}

		public function get text():String
		{
			return textField.text;
		}

		public function set text(value:String):void
		{
			if(textField.text==value)
				return;
			textField.text = value;
			updateAlign();
		}

		/**
		 *是否可编辑 
		 */
		public function get editable():Boolean
		{
			return _editable;
		}

		/**
		 * @private
		 */
		public function set editable(value:Boolean):void
		{
			_editable = value;
			textField.mouseEnabled=_editable;
			textField.selectable=_editable;
			textField.type=_editable?TextFieldType.INPUT:TextFieldType.DYNAMIC;
			
			if(value)
			{
				this.addEventListener(MouseEvent.ROLL_OVER,onTextInputMsOver);
				this.addEventListener(MouseEvent.ROLL_OUT,onTextInputMsOut);
				this.addGlobalEventListener(LStageEvent.STAGE_CLICK_EVENT,onStgClick);
			}
			else
			{
				this.removeEventListener(MouseEvent.ROLL_OVER,onTextInputMsOver);
				this.removeEventListener(MouseEvent.ROLL_OUT,onTextInputMsOut);
				this.removeGlobalEventListener(LStageEvent.STAGE_CLICK_EVENT,onStgClick);
			}
		}
		
		override protected function removeEvents():void
		{
			this.removeEventListener(MouseEvent.ROLL_OVER,onTextInputMsOver);
			this.removeEventListener(MouseEvent.ROLL_OUT,onTextInputMsOut);
			this.removeGlobalEventListener(LStageEvent.STAGE_CLICK_EVENT,onStgClick);
			super.removeEvents();
		}
		
		private function onTextInputMsOver():void
		{
			Mouse.cursor = MouseCursor.IBEAM;
		}
		
		private function onTextInputMsOut():void
		{
			Mouse.cursor = MouseCursor.AUTO;
			if(textHelpeMe)
			{
				text = textHelper.text;
			}
		}
		
		protected function onTextHelperStrChange(event:Event):void
		{
			if(textHelpeMe)
			{
				text = textHelper.text;
			}
		}
		
		/**
		 *  
		 * @param evt
		 * 
		 */
		private function onStgClick(evt:LStageEvent):void
		{
			if(evt.mouseTarget == this)
			{
				textHelper.defaultTextFormat = textField.defaultTextFormat;
				textHelper.textColor = textField.textColor;
				textHelper.type = TextFieldType.INPUT;
				textHelper.autoSize = TextFieldAutoSize.LEFT;
				textHelper.text = textField.text;
				locHelper.setTo(textField.x,textField.y);
				this.localToGlobal(locHelper,locHelper);
				textHelper.x = locHelper.x;
				textHelper.y = locHelper.y;
				textHelpeMe = true;
				textImg.visible = false;
				textField.autoSize = TextFieldAutoSize.NONE;
				LUIManager.starling.nativeStage.addChild(textHelper);
				textHelper.addEventListener(Event.CHANGE,onTextHelperStrChange);
				LUIManager.starling.nativeStage.focus = textHelper;
			}
			else
			{
				textHelper.removeEventListener(Event.CHANGE,onTextHelperStrChange);
				textHelpeMe = false;
				textImg.visible = true;
				textField.autoSize = TextFieldAutoSize.LEFT;
				updateAlign();
				
				var isLtext:Boolean = evt.mouseTarget is LText;
				if(!isLtext || (isLtext&&!(evt.mouseTarget as LText).editable))
				{
					if(textHelper.parent)
					{
						textHelper.parent.removeChild(textHelper);
					}
				}
			}
			
		}
		
		/**
		 *  内部 TextField
		 * 
		 */
		public function get textField():TextField
		{
			if(!_textfield)
			{
				_textfield=new TextField();
				_textfield.autoSize=TextFieldAutoSize.LEFT;
				textBmd = new BitmapData(_textfield.width,_textfield.height,true,0x0);
				textImg = new Image(Texture.fromBitmapData(textBmd));
				addChild(textImg);
			}
			return _textfield;
		}
		
		override public function set width(value:Number):void
		{
			super.width=value;
			updateAlign();
		}
		override public function set height(value:Number):void
		{
			super.height=value;
			updateAlign();
		}
		/**
		 *  自动收缩尺寸到刚好显示完文本内容
		 * */
		public function pack():void
		{
			width = textField.width;
			height = textField.height;
		}
		
		protected function updateAlign():void
		{
			switch(textAlign)
			{
				case UiConst.TEXT_ALIGN_TOP_LEFT:
					textField.x=textField.y=0;
					break;
				case UiConst.TEXT_ALIGN_TOP_CENTER:
					textField.y=0;
					LGeom.centerInCoordX(textField,this);
					break;
				case UiConst.TEXT_ALIGN_TOP_RIGHT:
					textField.x=width-textField.width;
					textField.y=0;
					break;
				case UiConst.TEXT_ALIGN_MIDDLE_LEFT:
					textField.x=0;
					LGeom.centerInCoordY(textField,this);
					break;
				case UiConst.TEXT_ALIGN_MIDDLE_CENTER:
					LGeom.center(textField,this);
					break;
				case UiConst.TEXT_ALIGN_MIDDLE_RIGHT:
					textField.x=width-textField.width;
					LGeom.centerInCoordY(textField,this);
					break;
				case UiConst.TEXT_ALIGN_BOTTOM_LEFT:
					textField.x=0;
					textField.y=height-textField.height;
					break;
				case UiConst.TEXT_ALIGN_BOTTOM_CENTER:
					textField.y=height-textField.height;
					LGeom.centerInCoordX(textField,this);
					break;
				case UiConst.TEXT_ALIGN_BOTTOM_RIGHT:
					textField.y=height-textField.height;
					textField.x=width-textField.width;
					break;
			}
			textField.x+=textOffX;
			textField.y+=textOffY;
			
			textBmd.dispose();
			textBmd = new BitmapData(width,height,true,0);
			textBmd.draw(textField,new Matrix(1,0,0,1,textField.x,textField.y));
			
			textImg.width = width;
			textImg.height = height;
			textImg.texture = Texture.fromBitmapData(textBmd);
		}
	}
}