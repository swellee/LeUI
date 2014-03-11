package decorators
{
	import flash.display.DisplayObject;
	
	import core.IDecorator;
	import core.IStyle;
	
	import utils.LFactory;
	
	import vos.StyleVO;
	
	/**
	 *@author swellee
	 *2013-4-3
	 *
	 */
	public class LDecorator implements IDecorator
	{
		public function LDecorator()
		{
		}
		
		public function decorate(ui:IStyle, styleVo:StyleVO):void
		{
			var bg:DisplayObject=LFactory.getDisplayObj(styleVo.assetClass);
			if(bg)
			{
				ui.setBg(bg);
			}
		}
	}
}