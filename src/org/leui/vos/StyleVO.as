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
	}
}