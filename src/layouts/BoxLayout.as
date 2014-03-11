package layouts
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import core.IMatirxContainer;
	import core.ILayoutContainer;
	import core.ILayoutElement;
	
	import errors.LTypeError;
	
	import utils.LGeom;
	import utils.UiConst;

	/**
	 *@author swellee
	 *2013-5-22
	 * 方形布局,可对容器内的对象进行横向或纵向排列,排列时按照加入容器的先后顺序对子对象应用分布
	 */
	public class BoxLayout extends BasicLayout
	{
		public function BoxLayout()
		{
			super();
		}
		override public function doLayout(contianer:ILayoutContainer):void
		{
			var listContainer:IMatirxContainer=contianer as IMatirxContainer;
			if(!listContainer)
			{
				throw new LTypeError("BoxLayout 's para must be IMatrixContainer");
			}
			
			var eles:Vector.<ILayoutElement>=listContainer.layoutElements;
			var eleCount:int=eles.length;
			var ele:ILayoutElement;
			var noneScaleEleCount:int=0;
			var noneScaleEleSizeSum:int=0;
			var isHorizonLayout:Boolean=listContainer.direction==UiConst.HORIZONTAL;
			var margin:int=isHorizonLayout?listContainer.hGap:listContainer.vGap;
			//计算不可缩放的子对象的数量和总尺寸
			for (var i:int = 0; i < eleCount; i++) 
			{
				ele=eles[i];
				var eleBounds:Rectangle=ele.bounds;
				if((isHorizonLayout&&!ele.canScaleX)||(!isHorizonLayout&&!ele.canScaleY))
				{
					noneScaleEleCount++;
					noneScaleEleSizeSum+=isHorizonLayout?eleBounds.width:eleBounds.height;
				}
			}
			var containerBounds:Rectangle=listContainer.bounds;
			var canScaleSizeLeft:int=(isHorizonLayout?containerBounds.width:containerBounds.height)-noneScaleEleSizeSum-eleCount*margin+margin;
			var maxEleSize:int=canScaleSizeLeft/(eleCount-noneScaleEleCount);
			//进行布局
			var eleLoc:int;
			for (var j:int = 0; j < eleCount; j++) 
			{
				ele=eles[j];
				if(isHorizonLayout)//如果是横向布局
				{
					ele.setXY(eleLoc,0);
					if(ele.canScaleX)//可缩放的元素，缩放到平均尺寸
					{
						ele.setWH(maxEleSize,containerBounds.height);
					}
					else//不 可缩放的元素，在Y轴居中
					{
						LGeom.centerInCoordY(ele as DisplayObject,listContainer as DisplayObjectContainer);
					}
					eleLoc+=ele.bounds.width+j*margin;
				}
				else
				{
					ele.setXY(0,eleLoc);
					if(ele.canScaleY)//可缩放的元素，缩放到平均尺寸
					{
						ele.setWH(containerBounds.width,maxEleSize);
					}
					else//不 可缩放的元素，在X轴居中
					{
						LGeom.centerInCoordX(ele as DisplayObject,listContainer as DisplayObjectContainer);
					}
					eleLoc+=ele.bounds.height+j*margin;
				}
			}
			
			
		}
	}
}