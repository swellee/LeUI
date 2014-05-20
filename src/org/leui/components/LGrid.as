package org.leui.components
{
	import org.leui.layouts.GridLayout;
	
	
	/**
	 *@author swellee
	 *2013-8-28
	 *
	 */
	public class LGrid extends LList
	{
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
			super(hGap,vGap);
			this._cols=cols;
			this._rows=rows;
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
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=GridLayout;
		}
		
	}
}