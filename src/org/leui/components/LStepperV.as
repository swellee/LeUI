package org.leui.components
{
	import org.leui.layouts.StepperVLayout;

	/**
	 *@author swellee
	 *2013-12-25
	 *纵向步进器
	 */
	public class LStepperV extends Stepper
	{
		public function LStepperV(eleBtnSize:int=20)
		{
			super(eleBtnSize);
		}
		override public function getLayoutManager():Class
		{
			return StepperVLayout;
		}
	}
}