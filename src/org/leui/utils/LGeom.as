package org.leui.utils
{
	import org.leui.components.LComponent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	/**
	 *   形状与位置工具类
	 *@author swellee
	 */
	public class LGeom
	{
		
		/**
		 *  将对象居中到目标坐标系
		 * @param obj 对象
		 * @param targetCoordinates 目标坐标空间
		 */
		public static function center(obj:DisplayObject, targetCoordinates:DisplayObjectContainer):void
		{
			centerInCoordX(obj,targetCoordinates);
			centerInCoordY(obj,targetCoordinates);
		}
		
		/**
		 *  将对象居中到目标坐标系的Y轴 
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
		 *  将对象居中到目标坐标系的X轴 
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
		
		/**
		 *  将对象显示限定在容器尺寸内 
		 * @param comp对象
		 * @param tx对象X
		 * @param ty对象Y
		 * @param containerBounds对象的父容器区域
		 * 
		 */
		public static function inRange(comp:LComponent, tx:int, ty:int, containerBounds:Rectangle):void
		{
			if(tx+comp.width>containerBounds.width)
				tx=containerBounds.width-comp.width;
			if(ty+comp.height>containerBounds.height)
				ty=containerBounds.height-comp.height;
			tx=Math.max(tx,0);
			ty=Math.max(ty,0);
			comp.setXY(tx,ty);
		}
	}
}