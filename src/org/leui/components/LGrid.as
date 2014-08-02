package org.leui.components
{
	import org.leui.layouts.GridLayout;
	import org.leui.utils.LTrace;
	
	
	/**
	 *   网格容器 LGrid会根据自身尺寸及子元素个数，对子元素尺寸进行缩放到统一的元素尺寸，
	 * 如果不想被缩放，可设置子元素的canScaleX和canScaleY属性为false，
	 * 但不推荐这么做，因为这将使布局后子元素显得不协调。
	 * </br>如果添加进来的元素总数并不总等于设置的行数乘以列数，LGrid会对子元素的行列数进行修正，
	 * 例如先设置 列数4，行数4，之后实际添加了20个元素，4x4 != 20，若设置了以列数为准，则自动修正为4列、5行。
	 *@author swellee
	 */
	public class LGrid extends LList
	{
		private var _lockCols:Boolean;
		private var _cols:int;
		private var _rows:int;
		/**
		 *   网格容器 
		 * @param cols 列数
		 * @param rows 行数
		 * @param hGap 横向间距
		 * @param vGap 纵向间距
		 * @param lockCols 当cols x rows !=子对象总数时，是否以列数为准。默认为true
		 * 
		 */
		public function LGrid(cols:int=2,rows:int=2,hGap:int=0,vGap:int=0,lockCols:Boolean=true)
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
		 *  当cols x rows !=子对象总数时，是否以列数为准 
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
		
		override public function set direction(val:int):void
		{
			LTrace.warnning("direction setter method is unavailable in LGrid");
			return;
		}
		
		override public function getLayoutManager():Class
		{
			return _layoutManager||=GridLayout;
		}
		
	}
}