package components
{
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import utils.LGeom;
	import utils.UiConst;

	/**
	 *@author swellee
	 *2013-4-6
	 *
	 */
	public class LText extends LComponent
	{
		private var _textfield:TextField;
		private var _editable:Boolean;
		private var _text:String="";
		private var _viewBounds:Rectangle;
		private var _viewportMask:Shape;
		/**
		 *文字与外框边距 
		 */
		protected static const textFrameSpace:Number=4;
		private var textOffX:int;
		private var textOffY:int;
		private var textAlign:int;
		public function LText(text:String="",editable:Boolean=true)
		{
			super();
			this.text=text;
			this.editable=editable;
			width=UiConst.TEXT_DEFAULT_WIDTH;
			height=UiConst.TEXT_DEFAULT_HEIGHT;
		}

		/**
		 *设置文本内容的布局 
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
			textField.text=_text;
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			if(_text==value)
				return;
			_text = value;
			textField.text=_text;
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
		}
		
		public function get textField():TextField
		{
			if(!_textfield)
			{
				_textfield=new TextField();
				_textfield.autoSize=TextFieldAutoSize.LEFT;
				addChild(_textfield);
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
		/**自动收缩尺寸到刚好显示完文本内容*/
		public function pack():void
		{
			width=textField.textWidth+textFrameSpace;
			height=textField.textHeight+textFrameSpace;
		}
		
		private function updateAlign():void
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
		}
	}
}