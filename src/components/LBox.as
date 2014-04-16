package components
{
	import core.IMatirxContainer;
	
	import layouts.BoxLayout;

	/**
	 *@author swellee
	 *2014-2-23
	 *Box容器，子元素会自动根据元素数量均匀扩展尺寸到撑满box容器。
	 */
	public class LBox extends LPane implements IMatirxContainer
	{
		protected var _direction:int;
		protected var _hGap:int;
		protected var _vGap:int;
		/**
		 * @param hGap 横向间距  /像素
		 * @param vGap 竖向间距  /像素		
		 * 
		 */
		public function LBox(hGap:int=0,vGap:int=0)
		{
			super();
			this._hGap=hGap;
			this._vGap=vGap;
		}
		
		public function set direction(val:int):void
		{
			if(val!=_direction)
			{
				_direction=val;
				updateLayout();
			}
		}
		public function get direction():int
		{
			return _direction;
		}
		public function set hGap(val:int):void
		{
			if(val!=_hGap)
			{
				_hGap=val;
				updateLayout();
			}
		}
		
		public function get hGap():int
		{
			return _hGap;
		}
		
		public function set vGap(val:int):void
		{
			if(val!=_vGap)
			{
				_vGap=val;
				updateLayout();
			}
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