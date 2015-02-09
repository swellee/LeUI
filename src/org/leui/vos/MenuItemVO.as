package org.leui.vos
{
	import starling.display.DisplayObject;

	/**
	 *   菜单项数据
	 *@author swellee
	 */
	public class MenuItemVO
	{
		/**
		 *文本 
		 */
		public var text:String;
		/**
		 *图标 
		 */
		public var icon:DisplayObject;
		/**
		 *图标在X坐标上的偏移量 
		 */
		public var iconOffX:int;
		/**
		 *样式 
		 */
		public var style:String;
		
		/**
		 *绑定到LMenuItem的数据 
		 */
		public var data:*;
		
		/**
		 *子菜单项数据集 
		 */
		public var subMenuItemVos:Vector.<MenuItemVO>;
		
		public function MenuItemVO(text:String=null,icon:DisplayObject=null,iconOffX:int=0,style:String=null)
		{
			this.text=text;
			this.icon=icon;
			this.iconOffX=iconOffX;
			this.style=style;
		}
	}
}