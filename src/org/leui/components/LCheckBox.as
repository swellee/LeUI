package org.leui.components
{
	/**
	 *   复选框组件
	 *@author swellee
	 */
	public class LCheckBox extends LRadioButton
	{
		public function LCheckBox(txt:String=null)
		{
			super(txt);
		}
		override public function getDefaultStyle():String
		{
			return "LCheckBox";
		}
	}
}