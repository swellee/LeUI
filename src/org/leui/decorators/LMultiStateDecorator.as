package org.leui.decorators
{
	import org.leui.components.LMultiState;
	import org.leui.core.IDecorator;
	import org.leui.core.IStyle;
	import org.leui.utils.LTrace;
	import org.leui.vos.ChildStyleHashVO;
	import org.leui.vos.StyleVO;
	
	/**
	 *@author swellee
	 *  复态组件 装饰器
	 */
	public class LMultiStateDecorator implements IDecorator
	{
		public function LMultiStateDecorator()
		{
		}
		
		public function decorate(ui:IStyle, styleVo:StyleVO):void
		{
			var multiStateUi:LMultiState=ui as LMultiState;
			if(!multiStateUi)
				return;
			ui.clearBg();
			var childStyleHashs:Vector.<ChildStyleHashVO>=multiStateUi.stateStyleHash;
			for (var i:int = 0; i < childStyleHashs.length; i++) 
			{
				var hashVo:ChildStyleHashVO=childStyleHashs[i];
				try
				{
					//尝试读取stylevo里动态属性childName的值
					hashVo.childStyle=styleVo[hashVo.childName];
				} 
				catch(error:Error) 
				{
					LTrace.log("has not config "+hashVo.childName+"'s childStyle");
				}
			}
			multiStateUi.showState();
		}
	}
}