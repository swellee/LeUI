package org.leui.vos
{
	/**
	 *下拉菜单列表项数据
	 *2014-4-15
	 *@author swellee
	 */
	public class ComboxListVO
	{
		/**
		 *标签文本 
		 */
		public var label:String="";
		/**
		 *数据 
		 */
		public var data:*;
		public function ComboxListVO(labelStr:String=null,data:*=null)
		{
			this.label=labelStr;
			this.data=data;
		}
	}
}