package decorators
{
	import flash.display.DisplayObject;
	
	import core.Idecorator;
	import core.Istyle;
	
	import utils.LFactory;
	
	import vos.StyleVO;
	
	/**
	 *@author swellee
	 *2013-4-3
	 *
	 */
	public class LDecorator implements Idecorator
	{
		public function LDecorator()
		{
		}
		
		public function decorate(ui:Istyle, styleVo:StyleVO):void
		{
			var bg:DisplayObject=LFactory.getDisplayObj(styleVo.assetClass);
			if(bg)
			{
				ui.setBg(bg);
			}
		}
	}
}