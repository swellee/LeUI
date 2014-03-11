package utils
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 *@author swellee
	 *2013-1-6
	 *lexUI常量枚举
	 */
	public class UiConst
	{
		/**
		 *组件最大尺寸 
		 */
		public static const UI_MAX_SIZE:int=2048;
		/**
		 *组件最小尺寸 
		 */
		public static const UI_MIN_SIZE:int=1;
		/**
		 *图标组件的默认尺寸 
		 */
		public static const ICON_DEFAULT_SIZE:int=20;
		/**
		 *文本的默认宽度 
		 */
		public static const TEXT_DEFAULT_WIDTH:int=50;
		/**
		 *文本的默认高度 
		 */
		public static const TEXT_DEFAULT_HEIGHT:int=20;
		
		/**
		 *竖向 
		 */
		public static const VERTICAL:int=0;
		/**
		 *横向 
		 */
		public static const HORIZONTAL:int=1;
		/**
		 *位置 左 
		 */
		public static const LEFT:int=2;
		/**
		 *位置 右 
		 */
		public static const RIGHT:int=3;
		/**
		 *文本组件默认格式
		 */
		public static const TEXT_DEFAULT_FORMAT:TextFormat=new TextFormat(null,14,0,false,false,false,null,null,TextFormatAlign.CENTER);
		/**
		 *滚动条默认步进值 
		 */
		public static const SCROLLBAR_STEP_VALUE:int=4;
		/**
		 * 滚动条默认满值
		 */
		public static const SCROLLBAR_TOP_VALUE:int=100;
		/**
		 * 滚动条滑块的初始尺寸占滑动区域的百分比
		 */
		public static const SCROLLBAR_SLIDER_INIT_VALUE_SIZE:int=20;
		/**
		 *滚动面板中，滚动条显示规则——自动显示（即在需要时显示） 
		 */
		public static const SCROLLPANE_BAR_POLICY_AUTO:int=0;
		/**
		 *滚动面板中，滚动条显示规则——从不显示
		 */
		public static const SCROLLPANE_BAR_POLICY_NEVER:int=1;
		/**
		 *滚动面板中，滚动条显示规则——总是显示
		 */
		public static const SCROLLPANE_BAR_POLICY_ALWAYS:int=2;
		/**
		 * 滚动面板中，滚动条初始宽度
		 */
		public static const SCROLLPANE_BAR_INIT_SIZE:int=20;
		/**
		 *LText组件的文本布局——上左 
		 */
		public static const TEXT_ALIGN_TOP_LEFT:int=0;
		/**
		 *LText组件的文本布局——上中
		 */
		public static const TEXT_ALIGN_TOP_CENTER:int=1;
		/**
		 *LText组件的文本布局——上右
		 */
		public static const TEXT_ALIGN_TOP_RIGHT:int=2;
		/**
		 *LText组件的文本布局——中左 
		 */
		public static const TEXT_ALIGN_MIDDLE_LEFT:int=3;
		/**
		 *LText组件的文本布局——正中 
		 */
		public static const TEXT_ALIGN_MIDDLE_CENTER:int=4;
		/**
		 *LText组件的文本布局——中右 
		 */
		public static const TEXT_ALIGN_MIDDLE_RIGHT:int=5;
		/**
		 *LText组件的文本布局——底左 
		 */
		public static const TEXT_ALIGN_BOTTOM_LEFT:int=6;
		/**
		 *LText组件的文本布局——底中 
		 */
		public static const TEXT_ALIGN_BOTTOM_CENTER:int=7;
		/**
		 *LText组件的文本布局——底右 
		 */
		public static const TEXT_ALIGN_BOTTOM_RIGHT:int=8;
		/**
		 * LSeprator的固定尺寸
		 */
		public static const SEPRATOR_INIT_SIZE:int=2;
		
	}
}