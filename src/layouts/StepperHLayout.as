package layouts
{
	import mx.controls.Button;
	
	import components.LButton;
	import components.LStepperH;
	import components.LText;
	
	import core.ILayoutContainer;
	import core.ILayoutElement;
	import core.ILayoutManager;
	
	/**
	 *@author swellee
	 *2013-12-5
	 *LStepperH组件布局管理器
	 */
	public class StepperHLayout implements ILayoutManager
	{
		public function StepperHLayout()
		{
		}
		
		public function doLayout(contianer:ILayoutContainer):void
		{
			var stepper:LStepperH=contianer as LStepperH;
			if(!stepper)return;
			
			var btnSize:int=Math.min(stepper.eleBtnSize,stepper.height);
			stepper.ele_increase_btn.setWH(btnSize,btnSize);
			stepper.ele_decrease_btn.setWH(btnSize,btnSize);
			stepper.ele_text.setWH(stepper.width-stepper.eleGap*2-btnSize*2,stepper.height);
			
			stepper.ele_decrease_btn.setXY(0,0);
			stepper.ele_text.setXY(stepper.ele_decrease_btn.width+stepper.eleGap,0);
			stepper.ele_increase_btn.setXY(stepper.ele_text.x+stepper.ele_text.width+stepper.eleGap,0);
		}
	}
}