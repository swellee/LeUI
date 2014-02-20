package layouts
{
	import components.LStepperV;
	
	import core.IlayoutContainer;
	import core.IlayoutManager;
	
	/**
	 *@author swellee
	 *2013-12-25
	 *LStepperV布局管理器
	 */
	public class StepperVLayout implements IlayoutManager
	{
		public function StepperVLayout()
		{
		}
		
		public function doLayout(contianer:IlayoutContainer):void
		{
			var stp:LStepperV=contianer as LStepperV;
			if(!stp)return;
			
			var btnH:int=stp.height*.5;
			stp.ele_decrease_btn.setWH(stp.eleBtnSize,btnH);
			stp.ele_increase_btn.setWH(stp.eleBtnSize,btnH);
			stp.ele_text.setWH(stp.width,stp.height);

			stp.ele_increase_btn.setXY(stp.width-stp.eleBtnSize,0);
			stp.ele_decrease_btn.setXY(stp.width-stp.eleBtnSize,btnH);
		}
	}
}