package org.leui.errors
{
	/**
	 *  重写方法错误对象，提示子类需要或者禁止重写父类的方法
	 *@author swellee
	 */
	public class LOverrideError extends LError
	{
		public function LOverrideError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}