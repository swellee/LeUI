package org.leui.utils
{
	import flash.utils.Dictionary;

	/**
	 *   哈希表
	 * @see put();
	 * @see find();
	 *@author swellee
	 */
	public class LHash
	{
		private var _dic:Dictionary;
		private var _keys:Array;
		private var _values:Array;
		public function LHash()
		{
		}

		/**
		 *值的集合 
		 * @return 
		 * 
		 */
		public function get values():Array
		{
			return _values ||= [];
		}

		/**
		 *键的集合 
		 * @return 
		 * 
		 */
		public function get keys():Array
		{
			return _keys ||= [];
		}

		public function get dic():Dictionary
		{
			return _dic||=new Dictionary(true);
		}

		/**
		 *  放入字典中 
		 * @param key键名
		 * @param value键值（对象）
		 * 
		 */
		public function put(key:Object,value:Object):void
		{
			dic[key]=value;
			keys.push(key);
			values.push(value);
		}
		/**
		 *  从字典里查找对象 
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
		 *   从字典里移出对象
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
			}
			var idx:int = keys.indexOf(key);
			if(idx>-1)
			{
				keys.splice(idx,1);
			}
			if(v&&((idx= values.indexOf(v))>-1))
			{
				values.splice(idx,1);
			}
			return v;
		}
		/**
		 *  检测是否在字典中 
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
		 *  清空字典 
		 */
		public function clear():void
		{
			_dic=null;
			_keys = [];
			_values = [];
		}
		/**
		 *  字典长度（内容总数） 
		 * @return 
		 */
		public function get length():int
		{
			return keys.length;
		}
	}
}