package org.leui.layouts
{
	import org.leui.components.LScrollPane;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutManager;
	import org.leui.utils.UiConst;
	
	/**
	 *  滚动面板布局管理
	 *@author swellee
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
			var viewW:int = /*scrPane.ele_v_scroll_bar.visible?*/scrPane.width-scrBarSize/*:scrPane.width*/;
			var viewH:int = /*scrPane.ele_h_scroll_bar.visible?*/scrPane.height-scrBarSize/*:scrPane.height*/;
			scrPane.ele_view_port.setWH(viewW,viewH);
			// scrollbar
			scrPane.ele_h_scroll_bar.setWH(scrPane.width-scrBarSize,scrBarSize);
			scrPane.ele_v_scroll_bar.setWH(scrBarSize,scrPane.height-scrBarSize);
			scrPane.ele_h_scroll_bar.setXY(0,scrPane.height-scrBarSize);
			scrPane.ele_v_scroll_bar.setXY(scrPane.width-scrBarSize,0);
		}
	}
}