package org.leui.vos
{
	import org.leui.utils.LeSpace;
	

	/**
	 *  样式信息
	 *@author swellee
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
		 *此样式信息的使用对象（此属性仅编辑器使用） 
		 */
		LeSpace var user:String;
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
			vo.user = this.user;
			
			//dynamic attributes
			for(var att:String in this)
			{
				vo[att] = this[att];
			}
			return vo;
		}
	}
}