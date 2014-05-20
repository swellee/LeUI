package org.leui.layouts
{
	import org.leui.components.LStepperV;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutManager;
	
	
	/**
	 *@author swellee
	 *2013-12-25
	 *LStepperV布局管理器
	 */
	public class StepperVLayout implements ILayoutManager
	{
		public function StepperVLayout()
		{
		}
		
		public function doLayout(contianer:ILayoutContainer):void
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