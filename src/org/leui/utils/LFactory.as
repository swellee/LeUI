package org.leui.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	/**
	 *  工厂类
	 *@author swellee
	 */
	public class LFactory
	{
		private static var assetPool:Dictionary = new Dictionary(true);
		/**
		 *  取一个显示类的实例 
		 * 优先从缓存池中取，缓存池中无则创建一个新实例
		 * @param ref
		 * @return 
		 * @see UiConst.ASSET_POOL_INSTANCE_MAX
		 */
		public static function  getDisplayObj(ref:Class):DisplayObject
		{
			if(ref)
			{
				var clsName:String = LUIManager.getClassName(ref);
				if(assetPool[clsName]&&assetPool[clsName].length)
				{
					return assetPool[clsName].pop() as DisplayObject;
				}
				else
				{
					assetPool[clsName] ||= [];
					return new ref()as DisplayObject;
				}
			}
			return null;
		}
		
		/**
		 *  将显示对象实像放回缓存池 
		 * 只有从getDisplayObj（）方法出去的对象才能被重新回收,且回收对象数量有最大限值
		 * @param obj
		 * 	@see UiConst.ASSET_POOL_INSTANCE_MAX
		 */
		LeSpace static function putDisplayObj(obj:DisplayObject):void
		{
			var clsName:String = LUIManager.getClassName(obj);
			if(assetPool[clsName])
			{
				var arr:Array = assetPool[clsName] as Array;
				if(arr.length<UiConst.ASSET_POOL_INSTANCE_MAX)
				{
					arr.push(obj);
				}
				else 
				{
					disposeDisplayObj(obj);
				}
			}
		}
		
		/**
		 *  销毁显示对象 
		 * @param obj
		 * 
		 */
		public static function disposeDisplayObj(obj:DisplayObject):void
		{
			if(obj is DisplayObjectContainer)
			{
				var comp:DisplayObjectContainer = obj as DisplayObjectContainer;
				var childCnt:int=comp.numChildren;
				while(--childCnt>-1)
				{
					var chld:DisplayObject=comp.removeChildAt(childCnt);
					disposeDisplayObj(chld);
				}
			}
			else if(obj.parent)
			{
				obj.parent.removeChild(obj);
			}
			else if(obj is MovieClip)
			{
				(obj as MovieClip).stop();
			}
			else if(obj is Bitmap)
			{
				(obj as Bitmap).bitmapData.dispose();
			}
			
		}
		
		/**
		 *  清理缓存池中的所在资源实例 
		 * 此方法会在更换样式表时被调用
		 */
		LeSpace static function disposeAssetPool():void
		{
			for each (var arr:Array in assetPool) 
			{
				for each(var obj:DisplayObject in arr)
				{
					disposeDisplayObj(obj);
				}
			}
			assetPool = new Dictionary(true);
		}
		
		/**
		 *  生成一个新实例 
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