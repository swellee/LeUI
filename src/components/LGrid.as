package components
{
	import core.IMatrixContainer;
	
	/**
	 *@author swellee
	 *2013-8-28
	 *
	 */
	public class LGrid extends LPane implements IMatrixContainer
	{
		private var _hGap:int;
		private var _vGap:int;
		private var _lockCols:Boolean;
		private var _cols:int;
		private var _rows:int;
		/**
		 * 网格容器 
		 * @param cols 列数
		 * @param rows 行数
		 * @param hGap 横向间距
		 * @param vGap 纵向间距
		 * @param lockCols 当cols x rows !=子对象总数时，是否以列数为准。默认为true
		 * 
		 */
		public function LGrid(cols:int,rows:int=1,hGap:int=0,vGap:int=0,lockCols:Boolean=true)
		{
			super();
			this._cols=cols;
			this._rows=rows;
			this._hGap=hGap;
			this._vGap=vGap;
			this._lockCols=lockCols;
		}
		

		public function get cols():int
		{
			return _cols;
		}

		public function set cols(value:int):void
		{
			_cols = value;
		}

		public function get rows():int
		{
			return _rows;
		}

		public function set rows(value:int):void
		{
			_rows = value;
		}

		/**
		 *当cols x rows !=子对象总数时，是否以列数为准 
		 * 
		 */
		public function get lockCols():Boolean
		{
			return _lockCols;
		}

		public function set lockCols(value:Boolean):void
		{
			_lockCols = value;
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
			if(val==_hGap)return;
			_hGap=val;
			updateLayout();
		}
		
		public function get hGap():int
		{
			return _hGap;
		}
		
		public function set vGap(val:int):void
		{
			if(val==_vGap)return;
			_vGap=val;
			updateLayout();
		}
		
		public function get vGap():int
		{
			return _vGap;
		}
	}
}