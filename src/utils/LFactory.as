package utils
{
	import flash.display.DisplayObject;

	/**
	 *@author swellee
	 *2012-12-29
	 *
	 */
	public class LFactory
	{
		public static function  getDisplayObj(ref:Class):DisplayObject
		{
			if(ref)
				return new ref()as DisplayObject;
			return null;
		}
	}
}