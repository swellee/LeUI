package org.leui.layouts
{
	import flash.geom.Rectangle;
	
	import org.leui.components.LScrollBar;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutManager;
	import org.leui.utils.LTrace;

	/**
	 *   滚动条布局管理
	 *@author swellee
	 */
	public class ScrollbarLayout implements ILayoutManager
	{
		public function ScrollbarLayout()
		{
		}
		
		public function doLayout(contianer:ILayoutContainer):void
		{
			var scrBar:LScrollBar=contianer as LScrollBar;
			if(!scrBar)return;
			
			var containerBounds:Rectangle=scrBar.bounds;
			var cWidth:int=containerBounds.width;
			var cHeight:int=containerBounds.height;
			try
			{
				//背景条，缩放到整体大小
				scrBar.ele_bg.setWH(cWidth,cHeight);
				//减量按键,放到顶端
				scrBar.ele_decrease_btn.setXY(0,0);
				
				//滚动条为竖向
				if(scrBar.isVertical)
				{
					//减量按键宽高都缩放到容器宽度
					scrBar.ele_decrease_btn.setWH(cWidth,cWidth);
					//增量按键 放到底端，其宽高都缩放到容器宽度
					scrBar.ele_increase_btn.setWH(cWidth,cWidth);
					scrBar.ele_increase_btn.setXY(0,cHeight-cWidth);
				}
				else
				{
					//减量按键,宽高都缩放到容器高度
					scrBar.ele_decrease_btn.setWH(cHeight,cHeight);
					//增量按键 放到底端，其宽高都缩放到容器高度
					scrBar.ele_increase_btn.setWH(cHeight,cHeight);
					scrBar.ele_increase_btn.setXY(cWidth-cHeight,0);
					
				}
				//设置滑动条尺寸及位置
				scrBar.updateSlider()
			} 
			catch(error:Error) 
			{
				LTrace.log("Error in ScrollbarLayout or LScrollBar >>"+error);
			}
		}
	}
}