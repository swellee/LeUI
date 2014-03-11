package core
{
	import utils.LeSpace;

	use namespace LeSpace;
	/**
	 *@author swellee
	 *2014-3-8
	 *LContainer内部容器
	 */
	public class InnerContainer extends LSprite
	{
		/**
		 *是否是IlistContainer的内部容器 
		 */
		LeSpace var isListContainer:Boolean;
		public function InnerContainer()
		{
			super();
		}
	}
}