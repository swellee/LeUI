package layouts
{
	import components.LList;
	
	import core.ILayoutContainer;
	import core.ILayoutElement;
	import core.ILayoutManager;
	
	import utils.UiConst;
	
	/**
	 *@author swellee
	 *2013-7-10
	 *列表容器布局管理
	 */
	public class ListLayout implements ILayoutManager
	{
		public function ListLayout()
		{
		}
		
		public function doLayout(contianer:ILayoutContainer):void
		{
			var list:LList=contianer as LList;
			if(!list)return;
			
			var eles:Vector.<ILayoutElement>=list.layoutElements;
			for (var i:int = 0; i < eles.length; i++) 
			{
				var child:ILayoutElement=eles[i];
				var loc:int;
				if(list.direction==UiConst.VERTICAL)
				{
					loc=(list.vGap+child.bounds.height)*i;
					child.setXY(0,loc);
				}
				else
				{
					loc=(list.hGap+child.bounds.width)*i;
					child.setXY(loc,0);
				}
			}
			
		}
	}
}