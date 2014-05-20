package org.leui.vos
{
	/**
	 *@author swellee
	 *2013-4-7
	 *多状态UI组件的 状态－－该状态的样式 映射
	 */
	public class ChildStyleHashVO
	{
		/**状态名*/
		public var childName:String;
		/**状态样式*/
		public var childStyle:String;
		public function ChildStyleHashVO(childName:String,childStyle:String=null)
		{
			this.childName=childName;
			this.childStyle=childStyle;
		}
	}
}