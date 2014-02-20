package layouts
{
	import components.LScrollPane;
	
	import core.IlayoutContainer;
	import core.IlayoutManager;
	
	import utils.UiConst;
	
	/**
	 *@author swellee
	 *2013-7-6
	 *滚动面板布局管理
	 */
	public class ScrollPaneLayout implements IlayoutManager
	{
		public function ScrollPaneLayout()
		{
		}
		
		public function doLayout(contianer:IlayoutContainer):void
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