package org.leui.components
{
	import org.leui.layouts.StepperHLayout;
	
	/**
	 * 横向步进组件，步进按钮分布在数字框的左右两侧
	 *@author swellee
	 *2013-12-5
	 *
	 */
	public class LStepperH extends Stepper
	{
		private var _eleGap:int;
		/**
		 * 
		 * @param eleGap 子元素横向布局的间距
		 * 
		 */
		public function LStepperH(eleBtnSize:int=26,eleGap:int=0)
		{
			super(eleBtnSize);
			this._eleGap=eleGap;
			
		}
		
		public function get eleGap():int
		{
			return _eleGap;
		}
		
		override public function getLayoutManager():Class
		{
			return StepperHLayout;
		}
	}
}