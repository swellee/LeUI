package org.leui.errors
{
	/**
	 *  类型不匹配
	 *@author swellee
	 */
	public class LTypeError extends LError
	{
		public function LTypeError(message:*="", id:*=0)
		{
			super("targetType Error  "+message, id);
		}
	}
}