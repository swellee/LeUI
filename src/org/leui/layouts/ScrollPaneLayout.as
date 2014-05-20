package org.leui.layouts
{
	import org.leui.components.LScrollPane;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutManager;
	import org.leui.utils.UiConst;
	
	/**
	 *@author swellee
	 *2013-7-6
	 *滚动面板布局管理
	 */
	public class ScrollPaneLayout implements ILayoutManager
	{
		public function ScrollPaneLayout()
		{
		}
		
		public function doLayout(contianer:ILayoutContainer):void
		{
			var scrPane:LScrollPane=contianer as LScrollPane;
			if(!scrPane)return;
			
			//viewport
			var scrBarSize:int=UiConst.SCROLLPANE_BAR_INIT_SIZE;
			scrPane.ele_view_port.setWH(scrPane.width-scrBarSize,scrPane.height-scrBarSize);
			// scrollbar
			scrPane.ele_h_scroll_bar.setWH(scrPane.width-scrBarSize,scrBarSize);
			scrPane.ele_v_scroll_bar.setWH(scrBarSize,scrPane.height-scrBarSize);
			scrPane.ele_h_scroll_bar.setXY(0,scrPane.height-scrBarSize);
			scrPane.ele_v_scroll_bar.setXY(scrPane.width-scrBarSize,0);
		}
	}
}