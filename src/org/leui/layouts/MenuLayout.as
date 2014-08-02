package org.leui.layouts
{
	import flash.geom.Rectangle;
	
	import org.leui.components.LMenu;
	import org.leui.core.ILayoutContainer;
	import org.leui.utils.LGeom;
	import org.leui.utils.LUIManager;


	/**
	 *  菜单布局
	 *@author swellee
	 */
	public class MenuLayout extends ListLayout
	{
		public function MenuLayout()
		{
			super();
		}
		
		override public function doLayout(contianer:ILayoutContainer):void
		{
			super.doLayout(contianer);
			var menu:LMenu=contianer as LMenu;
			if(!menu) return;
			
			LGeom.inRange(menu,menu.popX,menu.popY,new Rectangle(0,0,LUIManager.stage.stageWidth,LUIManager.stage.stageHeight));
		}
	}
}