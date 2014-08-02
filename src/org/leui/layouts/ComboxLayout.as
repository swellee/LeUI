package org.leui.layouts
{
	import org.leui.components.LCombox;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutManager;
	import org.leui.utils.UiConst;
	
	/**
	 *  LCombox布局管理器
	 *@author swellee
	 */
	public class ComboxLayout implements ILayoutManager
	{
		public function ComboxLayout()
		{
		}
		
		public function doLayout(contianer:ILayoutContainer):void
		{
			var cb:LCombox=contianer as LCombox;
			if(!cb)return;
			
			cb.ele_text.setWH(cb.width,cb.height);
			cb.ele_btn.setWH(UiConst.COMBOX_BTN_SIZE,cb.height);
			cb.ele_scrollPane.setWH(cb.width,UiConst.COMBOX_LIST_HEIGHT);
			
			cb.ele_btn.setXY(cb.width-UiConst.COMBOX_BTN_SIZE,0);
			cb.ele_scrollPane.setXY(cb.x,cb.y+cb.height-1);
		}
	}
}