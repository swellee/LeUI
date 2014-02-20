package errors
{
	/**
	 *@author swellee
	 *2012-11-7
	 *
	 */
	public class LSingletonError extends LError
	{
		public function LSingletonError(message:*="", id:*=0)
		{
			super("Target is not Implement ISingleton", id);
		}
	}
}