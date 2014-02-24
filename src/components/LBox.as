package components
{
	import core.IMatrixContainer;
	
	import layouts.BoxLayout;
	
	/**
	 *@author swellee
	 *2014-2-23
	 *Box容器，子元素会自动根据元素数量均匀扩展尺寸到撑满box容器。
	 */
	public class LBox extends LPane implements IMatrixContainer
	{
		private var _hGap:int;
		private var _vGap:int;
		public function LBox(hGap:int=0,vGap:int=0)
		{
			super();
		}
		
		public function set direction(val:int):void
		{
		}
		
		public function get direction():int
		{
			return 0;
		}
		
		public function set hGap(val:int):void
		{
			_hGap=val;
		}
		
		public function get hGap():int
		{
			return _hGap;
		}
		
		public function set vGap(val:int):void
		{
			_vGap=val;
		}
		
		public function get vGap():int
		{
			return _vGap;
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=BoxLayout;
		}
	}
}