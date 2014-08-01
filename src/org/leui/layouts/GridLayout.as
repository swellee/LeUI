package org.leui.layouts
{
	import org.leui.components.LGrid;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutElement;
	import org.leui.core.ILayoutManager;
	import org.leui.utils.LTrace;
	
	/**
	 *@author swellee
	 *2013-8-29
	 *网格布局
	 */
	public class GridLayout implements ILayoutManager
	{
		public function GridLayout()
		{
		}
		
		public function doLayout(contianer:ILayoutContainer):void
		{
			var grid:LGrid=contianer as LGrid;
			if(!grid)return;
			
			var eles:Vector.<ILayoutElement>=grid.layoutElements;
			var curCol:int;
			var curRow:int;
			var count:int=eles.length;
			if(count == 0)return;
			var lockCols:Boolean=grid.lockCols;
			var cols:int=grid.cols;
			var rows:int=grid.rows;
			if(lockCols)
			{
				rows = count/cols;
				if(count%cols>0)rows++;
			}
			else
			{
				cols=count/rows;
				if(count%rows>0)
					cols++;
			}
			var cellWidth:int = (grid.width-grid.hGap*(cols-1))/cols;
			var cellHeight:int = (grid.height-grid.vGap*(rows-1))/rows;
			
			for (var i:int = 0; i < count; i++) 
			{
				curRow=i/cols;
				curCol=i%cols;
				var eleComp:ILayoutElement=eles[i];
				var eleWidth:int=-1;
				var eleHeight:int=-1;
				if(eleComp.canScaleX)
					eleWidth=cellWidth;
				if(eleComp.canScaleY)
					eleHeight=cellHeight;
				eleComp.setWH(eleWidth,eleHeight);
				eleComp.setXY(curCol*(grid.hGap+cellWidth),curRow*(grid.vGap+cellHeight));
				
				//如果子对象不可缩放，则有可能应用布局后超出容器边界
				if(!(eleComp.canScaleX&&eleComp.canScaleY))
					LTrace.warnning("容器对象>>LGrid<<应用了GridLayout布局，但该容器包含不可缩放的子对象，有可能应用布局后子对象超出容器边界");
			}
		}
	}
}