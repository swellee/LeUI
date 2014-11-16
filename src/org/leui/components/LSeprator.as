package org.leui.components
{
	import org.leui.utils.UiConst;

	/**
	 *   分隔线,作用类似于flex里的Rule,横向时高度为固定值UiConst.SEPRATOR_INIT_SIZE;，纵向时宽度为固定值UiConst.SEPRATOR_INIT_SIZE;
	 *@author swellee
	 */
	public class LSeprator extends LComponent
	{
		private var _isHorizon:Boolean;
		/**
		 *  分隔线，默认为横向 
		 * @param isHorizon 是否横向
		 * 
		 */
		public function LSeprator(isHorizon:Boolean=true)
		{
			this._isHorizon=isHorizon;
			super();
		}

		public function get isHorizon():Boolean
		{
			return _isHorizon;
		}

		/**
		 * 是否横向 
		 * @param value
		 * 
		 */
		public function set isHorizon(value:Boolean):void
		{
			if(_isHorizon == value)return;
			_isHorizon = value;
			setWH(width,height);
		}

		override public function set width(value:Number):void
		{
			if(!isHorizon)
			{
				value=UiConst.SEPRATOR_INIT_SIZE;
			}
			super.width=value;
		}
		override public function set height(value:Number):void
		{
			if(isHorizon)
			{
				value=UiConst.SEPRATOR_INIT_SIZE;
			}
			super.height=value;
		}
		
		override public function getDefaultStyle():String
		{
			if(isHorizon)return "LSeprator";
			else return "LSepratorV";
		}
	}
}