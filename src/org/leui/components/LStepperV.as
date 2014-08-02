package org.leui.components
{
	import org.leui.layouts.StepperVLayout;

	/**
	 *  纵向步进器
	 *@author swellee
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