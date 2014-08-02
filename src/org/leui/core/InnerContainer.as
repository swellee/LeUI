package org.leui.core
{
	import org.leui.utils.LeSpace;

	use namespace LeSpace;
	/**
	 *  LContainer内部容器
	 *@author swellee
	 */
	public class InnerContainer extends LSprite
	{
		/**
		 *  是否是IlistContainer的内部容器 
		 */
		LeSpace var isListContainer:Boolean;
		/**
		 *  是否是ICombine的内部容器 
		 */
		LeSpace var isCombineContainer:Boolean;
		public function InnerContainer()
		{
			super();
		}
	}
}