package org.leui.components
{
	import org.leui.layouts.GridLayout;
	import org.leui.utils.LTrace;
	
	
	/**
	 *   网格容器 LGrid
	 * 如果某个子元素不想被缩放，可设置该子元素的canScaleX和canScaleY属性为false，
	 * 但不推荐这么做，因为这将使布局后子元素显得不协调。
	 * </br>如果添加进来的元素总数并不总等于设置的行数乘以列数，LGrid会对子元素的行列数进行修正，
	 * 例如先设置 列数4，行数4，之后实际添加了20个元素，4x4 != 20，若设置了以列数为准，则自动修正为4列、5行。
	 * LGrid还有一个canScaleElement属性，默认为true，用于全局控制是否对子元素进行统一缩放，以及是否自动修正行列数
	 * 如果设置为false，则不缩放子元素，也不修正行列数
	 * @see LGrid.canScaleElement
	 *@author swellee
	 */
	public class LGrid extends LList
	{
		private var _lockCols:Boolean;
		private var _cols:int;
		private var _rows:int;
		private var _canScaleElement:Boolean = true;
		/**
		 *   网格容器 
		 * @param cols 列数
		 * @param rows 行数
		 * @param hGap 横向间距
		 * @param vGap 纵向间距
		 * @param lockCols 当cols x rows !=子对象总数时，是否以列数为准。默认为true
		 * @see LGrid.canScaleElement
		 * 
		 */
		public function LGrid(cols:int=2,rows:int=2,hGap:int=0,vGap:int=0,lockCols:Boolean=true)
		{
			super(hGap,vGap);
			this._cols=cols;
			this._rows=rows;
			this._lockCols=lockCols;
		}
		
		/**
		 *  全局控制 是否自动对添加进来的子元素自行统一缩放， 默认为true。
		 * </br>而作为视口添加到LScrollPane时,<b>强烈建议</b>先将此属性值设置为false，否则因视口对子元素统一缩放，而导致永远不会显示滚动条（也就失去了使用LScrollPane的意义）
		 * </br>注意：当值为true时，hGap和vGap的值表示子元素缩放到统一尺寸后，相邻子元素边界之间的间距；
		 * </br>当值为false时，hGap和vGap的值表示原始子元素布局时，相邻子元素注册点之间的间距；
		 */
		public function get canScaleElement():Boolean
		{
			return _canScaleElement;
		}

		/**
		 * @private
		 */
		public function set canScaleElement(value:Boolean):void
		{
			if(value == _canScaleElement)return;
			_canScaleElement = value;
			updateLayout();
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