package org.leui.errors
{
	/**
	 *@author swellee
	 */
	public class LError extends Error
	{
		public function LError(message:*="", id:*=0)
		{
			super("LexUI_Error_"+message, id);
		}
	}
}