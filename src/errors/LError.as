package errors
{
	/**
	 *@author swellee
	 *2012-11-7
	 *
	 */
	public class LError extends Error
	{
		public function LError(message:*="", id:*=0)
		{
			super("LexUI_Error_"+message, id);
		}
	}
}