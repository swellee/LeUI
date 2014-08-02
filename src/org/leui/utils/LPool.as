package org.leui.utils
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	

	/**
	 *  实例缓存池（单例方式存储对象），仅供LexUIManager使用
	 *@author swellee
	 */
	internal class LPool
	{
		private static var pool:LHash=new LHash();
		/**
		 *获取实例 
		 * @param ref 实例或类
		 * @return 实例
		 * 无此实例则生成一个并存入池中
		 */		
		public static function find(ref:*):*
		{
			var refKey:String=getQualifiedClassName(ref);
			if(has(refKey))
				return pool.find(refKey);
			//未找到则创建并存入池中
			var refClass:Class=getDefinitionByName(refKey)as Class;
			if(!refClass)
				throw new Error("can't find the class named:"+refKey);
			var refInstance:*=new refClass();
			pool.put(refKey,refInstance);
			return refInstance;
		}
	
		public static function has(ref:*):Boolean
		{
			var refKey:String=ref as String;
			if(refKey==null||refKey=="")
				refKey=getQualifiedClassName(ref);
			return pool.has(refKey);
		}
		
		public static function clear():void
		{
			pool.clear();
		}
		public static function pop(ref:*):*
		{
			var refKey:String=getQualifiedClassName(ref);
			if(has(refKey))
			{
				var instance:*=pool[refKey];
				delete pool[refKey];
				return instance;
			}
			return null;
		}
	}
}