package components
{
	import core.IMatrixContainer;
	
	import layouts.ListLayout;
	
	import utils.UiConst;

	/**
	 *@author swellee
	 *2013-7-10
	 *列表容器
	 */
	public class LList extends LPane implements IMatrixContainer
	{
		private var _gap:int;
		private var _direction:int;
		/**
		 *列表容器 
		 * @param gap 间距  /像素
		 * @param vertical 是否为竖向滚动条，默认为true
		 * 
		 */
		public function LList(gap:int=0,vertical:Boolean=true)
		{
			super();
			if(vertical)
			{
				this.vGap=gap;
				this.direction=UiConst.VERTICAL;
			}
			else
			{
				this.hGap=gap;
				this.direction=UiConst.HORIZONTAL;
			}
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=ListLayout;
		}

		public function set direction(val:int):void
		{
			_direction=val;
		}
		public function get direction():int
		{
			return _direction;
		}
		public function set hGap(val:int):void
		{
			_gap=val;
		}
		public	function get hGap():int
		{
			return _gap;
		}
		public	function set vGap(val:int):void
		{
			_gap=val;
		}
		public	function get vGap():int
		{
			return _gap;
		}

	}
}