package org.leui.layouts
{
	import org.leui.components.LList;
	import org.leui.core.ILayoutContainer;
	import org.leui.core.ILayoutElement;
	import org.leui.core.ILayoutManager;
	import org.leui.utils.UiConst;
	
	/**
	 *  列表容器布局管理
	 *@author swellee
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