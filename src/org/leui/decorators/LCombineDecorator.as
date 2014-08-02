package org.leui.decorators
{
	import flash.display.DisplayObject;
	
	import org.leui.components.LCombine;
	import org.leui.core.IDecorator;
	import org.leui.core.IStyle;
	import org.leui.utils.LFactory;
	import org.leui.utils.LTrace;
	import org.leui.vos.ChildStyleHashVO;
	import org.leui.vos.StyleVO;
	
	/**
	 *   复合组件装饰类
	 *@author swellee
	 */
	public class LCombineDecorator implements IDecorator
	{
		public function LCombineDecorator()
		{
		}
		
		public function decorate(ui:IStyle, styleVo:StyleVO):void
		{
			var combUI:LCombine=ui as LCombine;
			if(!combUI)return;
			ui.clearBg();
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