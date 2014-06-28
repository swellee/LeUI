package org.leui.utils
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
		/**
		 *生成一个新实例 
		 * @param clazz 类
		 * @param args 构造函数的参数，最大允许有9个
		 * @return  新实例
		 * 
		 */
		public static function newInstance(clazz:Class,...args):Object
		{
			switch(args.length)
			{
				case 0:
					return new clazz();
				case 1:
					return new clazz(args[0]);
				case 2:
					return new clazz(args[0],args[1]);
				case 3:
					return new clazz(args[0],args[1],args[2]);
				case 4:
					return new clazz(args[0],args[1],args[2],args[3]);
				case 5:
					return new clazz(args[0],args[1],args[2],args[3],args[4]);
				case 6:
					return new clazz(args[0],args[1],args[2],args[3],args[4],args[5]);
				case 7:
					return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
				case 8:
					return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
				case 9:
					return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8]);
			}
			return null;
		}
		
	}
}