package components
{
	import flash.events.MouseEvent;

	/**
	 *@author swellee
	 *2013-5-9
	 *
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