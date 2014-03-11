package components
{
	import core.IStyleSheet;
	
	import utils.LHash;
	
	import vos.StyleVO;
	
	/**
	 *@author swellee
	 *2013-5-23
	 *样式表基类
	 */
	public class LStyleSheet implements IStyleSheet
	{
		private var styleHash:LHash;
		public function LStyleSheet()
		{
			styleHash=new LHash();
			initStyleSet();
		}
		/**初始化样式列表，子类重写此方法，可将默认组件的样式资源由此方法添加到缓存中*/
		protected function initStyleSet():void
		{
			
		}
		
		public function putStyleVO(styleVo:StyleVO):void
		{
			styleHash.put(styleVo.styleName,styleVo);
		}
		
		public function getStyleVO(styleName:String):StyleVO
		{
			return styleHash.find(styleName)as StyleVO;
		}
	}
}