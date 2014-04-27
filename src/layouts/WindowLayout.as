package layouts
{
	import components.LWindow;
	
	import core.ILayoutContainer;
	import core.ILayoutManager;
	
	import utils.UiConst;
	
	/**
	 *
	 *2014-4-26
	 *@author swellee
	 */
	public class WindowLayout implements ILayoutManager
	{
		public function WindowLayout()
		{
		}
		
		public function doLayout(contianer:ILayoutContainer):void
		{
			var window:LWindow = contianer as LWindow;
			if(!window)return;
			
			var border:int=UiConst.WINDOW_BORDER_SIZE;
			var eleWidth:int=window.width-border*2;
			window.ele_title_txt.setWH(eleWidth-UiConst.WINDOW_TITLE_BORDER_MARGIN*2,UiConst.WINDOW_TITLE_HEIGHT);
			window.ele_content_pane.setWH(eleWidth,window.height-border*2-UiConst.WINDOW_TITLE_HEIGHT);
			window.ele_close_btn.setWH(UiConst.WINDOW_BUTTON_WIDTH,UiConst.WINDOW_BUTTON_HEIGHT);
			
			window.ele_title_txt.setXY(border+UiConst.WINDOW_TITLE_BORDER_MARGIN,border);
			window.ele_content_pane.setXY(border,border+UiConst.WINDOW_TITLE_HEIGHT);
			window.ele_close_btn.setXY(window.width-UiConst.WINDOW_BUTTON_WIDTH-border,border);
		}
	}
}