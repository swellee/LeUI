package org.leui.errors
{
	/**
	 *  缺少属性错误
	 *@author swellee
	 */
	public class LPropteyError extends LError
	{
		public function LPropteyError(message:*="", id:*=0)
		{
			super("the object lack property of:"+message, id);
		}
	}
}