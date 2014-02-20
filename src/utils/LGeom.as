package utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 *@author swellee
	 *2013-1-26
	 * 形状与位置工具类
	 */
	public class LGeom
	{
		
		/**
		 *将对象居中到目标坐标系
		 * @param obj 对象
		 * @param targetCoordinates 目标坐标空间
		 */
		public static function center(obj:DisplayObject, targetCoordinates:DisplayObjectContainer):void
		{
			centerInCoordX(obj,targetCoordinates);
			centerInCoordY(obj,targetCoordinates);
		}
		
		/**
		 *将对象居中到目标坐标系的Y轴 
		 * @param obj 对象
		 * @param targetCoordinates 目标坐标空间
		 * @param offSet 偏移量
		 * 
		 */
		public static function centerInCoordY(obj:DisplayObject, targetCoordinates:DisplayObjectContainer, offSet:int=0):void
		{
			obj.y=(targetCoordinates.height-obj.height)/2;
			obj.y +=offSet;
		}
		
		/**
		 *将对象居中到目标坐标系的X轴 
		 * @param obj 对象
		 * @param targetCoordinates 目标坐标空间
		 * @param offSet 偏移量
		 * 
		 */
		public static function centerInCoordX(obj:DisplayObject, targetCoordinates:DisplayObjectContainer,  offSet:int=0):void
		{
			obj.x=(targetCoordinates.width-obj.width)/2;
			obj.x +=offSet;
		}
	}
}