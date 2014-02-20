package decorators
{
	import flash.display.DisplayObject;
	
	import components.LCombine;
	
	import core.Idecorator;
	import core.Istyle;
	
	import utils.LFactory;
	import utils.LTrace;
	
	import vos.ChildStyleHashVO;
	import vos.StyleVO;
	
	/**
	 *@author swellee
	 *2013-5-26
	 * 复合组件装饰类
	 */
	public class LCombineDecorator implements Idecorator
	{
		public function LCombineDecorator()
		{
		}
		
		public function decorate(ui:Istyle, styleVo:StyleVO):void
		{
			var combUI:LCombine=ui as LCombine;
			if(!combUI)return;
			
			//如果有自身配置的背景
			if(styleVo.assetClass)
			{
				var bg:DisplayObject=LFactory.getDisplayObj(styleVo.assetClass);
				if(bg)
				{
					ui.setBg(bg);
				}
			}
			//设置子对象的样式 
			for each (var childVo:ChildStyleHashVO in combUI.elementStyleHash) 
			{
				try
				{
					childVo.childStyle=styleVo[childVo.childName];
				} 
				catch(error:Error) 
				{
					LTrace.log("has not config "+childVo.childName+"'s childStyle");
				}
			}
			combUI.applyElementStyles();
		}
	}
}