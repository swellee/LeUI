package decorators
{
	import components.LMultiState;
	
	import core.IDecorator;
	import core.IStyle;
	
	import utils.LTrace;
	
	import vos.ChildStyleHashVO;
	import vos.StyleVO;
	
	/**
	 *@author swellee
	 *2013-4-24
	 *
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