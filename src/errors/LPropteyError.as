package errors
{
	/**
	 *@author swellee
	 *2012-12-29
	 *
	 */
	public class LPropteyError extends LError
	{
		public function LPropteyError(message:*="", id:*=0)
		{
			super("the object lack property of:"+message, id);
		}
	}
}