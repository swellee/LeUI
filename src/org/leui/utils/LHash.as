package org.leui.utils
{
	import flash.utils.Dictionary;

	/**
	 *@author swellee
	 *2012-11-7
	 * @see put();
	 * @see find();
	 */
	public class LHash
	{
		private var _dic:Dictionary;
		private var len:int;
		public function LHash()
		{
		}

		protected function get dic():Dictionary
		{
			return _dic||=new Dictionary(true);
		}

		/**
		 *放入字典中 
		 * @param key键名
		 * @param value键值（对象）
		 * 
		 */
		public function put(key:Object,value:Object):void
		{
			dic[key]=value;
			len++;
		}
		/**
		 *从字典里查找对象 
		 * @param key键名
		 * @return 键值（对象）
		 * 
		 */
		public function find(key:Object):Object
		{
			if(key in dic)
				return dic[key];
			return null;
		}
		/**
		 * 从字典里移出对象
		 * @param key键名
		 * @return 键值（对象）
		 * 
		 */
		public function pop(key:Object):Object
		{
			var v:Object=null;
			if(key in dic)
			{
				v=dic[key];
				delete dic[key];
				len--;
			}
			return v;
		}
		/**
		 *检测是否在字典中 
		 * @param key 键名
		 * @return 
		 * 
		 */
		public function has(key:Object):Boolean
		{
			if(key in dic)
				return true;
			return false;
		}
		/**
		 *清空字典 
		 */
		public function clear():void
		{
			_dic=null;
			len=0;
		}
		/**
		 *字典长度（内容总数） 
		 * @return 
		 */
		public function get length():int
		{
			return len;
		}
	}
}