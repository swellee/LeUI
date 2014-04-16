package layouts
{
	import components.LMenu;
	
	import core.ILayoutContainer;
	
	import flash.geom.Rectangle;
	
	import utils.LGeom;
	import utils.LUIManager;


	/**
	 *@author swellee
	 *2014-4-9
	 *
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