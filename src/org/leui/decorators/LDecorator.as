package org.leui.decorators
{
	import flash.display.DisplayObject;
	
	import org.leui.core.IDecorator;
	import org.leui.core.IStyle;
	import org.leui.utils.LFactory;
	import org.leui.vos.StyleVO;
	
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