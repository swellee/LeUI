package org.leui.components
{
	import flash.events.MouseEvent;

	/**
	 *  开关按钮，点击后自动切换选中状态
	 *@author swellee
	 */
	public class LToggleButton extends LButton
	{
		public function LToggleButton(text:String=null)
		{
			super(text);
		}
		override protected function onMouseUpHandler(event:MouseEvent):void
		{
			selected=!selected;
			super.onMouseUpHandler(event);
		}
	}
}