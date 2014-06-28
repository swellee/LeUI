package org.leui.vos
{

	/**
	 *@author swellee
	 *2013-4-3
	 *
	 */
	public dynamic class StyleVO
	{
		/**
		 *样式名 
		 */
		public var styleName:String;
		/**
		 *装饰类 （需要是Idecorator子类）
		 */
		public var decoratorClass:Class;
		/**
		 *资源类（需是IDisplayObject子类） 
		 */
		public var assetClass:Class;
		
		/**
		 *复制 
		 * @return 一个复制的StyleVO
		 * <br>注意：此方法对实例的动态属性数据用的是浅复制，
		 * 因此，如果实例的某动态属性指向一个复杂数据类型的实例，请避免使用此方法。
		 */
		public function clone():StyleVO
		{
			var vo:StyleVO = new StyleVO();
			vo.styleName = this.styleName;
			vo.decoratorClass = this.decoratorClass;
			vo.assetClass = this.assetClass;
			
			//dynamic attributes
			for(var att:String in this)
			{
				vo[att] = this[att];
			}
			return vo;
		}
	}
}