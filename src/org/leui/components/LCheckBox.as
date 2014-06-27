package org.leui.components
{
	/**
	 *@author swellee
	 *2013-5-23
	 * 复选框组件
	 */
	public class LCheckBox extends LRadioButton
	{
		public function LCheckBox(text:String=null)
		{
			super(text);
		}
		override public function getDefaultStyle():String
		{
			return "LCheckBox";
		}
	}
}