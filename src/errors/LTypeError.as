package errors
{
	/**
	 *@author swellee
	 *2012-11-7
	 *
	 */
	public class LTypeError extends LError
	{
		public function LTypeError(message:*="", id:*=0)
		{
			super("targetType is not "+message, id);
		}
	}
}