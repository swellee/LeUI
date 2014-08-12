package org.leui.utils
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;

	/**
	 *  LeUI常量枚举
	 *@author swellee
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
		 *树节点图标组件的默认尺寸 
		 */
		public static const TREENODE_EXTRA_BTN_SIZE:int=12;
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
		 *LText组件的文本布局——无布局
		 */
		public static const TEXT_ALIGN_NONE:int=-1;
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
		/**
		 *一级菜单的默认宽度 
		 */
		public static const MENU_PRIMARY_WIDTH:int=120;
		/**
		 *二级菜单的默认宽度 
		 */
		public static const MENU_SUB_WIDTH:int=80;
		/**
		 *菜单项的行间距 
		 */
		public static const MENU_ITEM_GAP:int=1;
		/**
		 *菜单项的高 
		 */
		public static const MENU_ITEM_HEIGHT:int=22;
		/**
		 *菜单项内，示意有子级菜单的箭头线颜色 
		 */
		public static const MENU_ITEM_SUB_TAG_COLOR:uint=0x0;
		/**
		 * 下拉菜单子元素--下拉按钮的默认宽度,默认使用滚动条的缺省宽度
		 */
		public static const COMBOX_BTN_SIZE:int=SCROLLPANE_BAR_INIT_SIZE;
		/**
		 * 下拉菜单子元素--下拉列表的默认高度
		 */
		public static const COMBOX_LIST_HEIGHT:int=160;
		/**
		 *视窗--边界尺寸；即视窗内的子元素与视窗最外缘的间距 
		 */
		public static const WINDOW_BORDER_SIZE:int=6;
		/**
		 *视窗--标题高度 （建议自行修改）
		 */
		public static var WINDOW_TITLE_HEIGHT:int=30;
		/**
		 *视窗--按钮的宽（建议自行修改）
		 */
		public static var WINDOW_BUTTON_WIDTH:int=22;
		/**
		 *视窗--按钮的高 （建议自行修改）
		 */
		public static var WINDOW_BUTTON_HEIGHT:int=18;
		/**
		 *视窗--标题元素与视窗边界的距离 （建议自行修改）
		 */
		public static var WINDOW_TITLE_BORDER_MARGIN:int=60;
		/**
		 *消息弹窗（LAlert) 控制按钮的尺寸--宽度 （建议自行修改）
		 */
		public static var ALERT_BUTTON_WIDTH:int=60;
		/**
		 *消息弹窗（LAlert) 控制按钮的尺寸--高度 （建议自行修改）
		 */
		public static var ALERT_BUTTON_HEIGHT:int=26;
		/**
		 *消息弹窗（LAlert) 控制按钮距离内容面板底边的距离 （建议自行修改）
		 */
		public static var ALERT_BUTTON_BODER_MARGIN:int=50;
		/**
		 * 消息弹窗（LAlert) 初始化尺寸--宽度
		 */
		public static var ALERT_INIT_WIDTH:int=350;
		/**
		 * 消息弹窗（LAlert) 初始化尺寸--高度
		 */
		public static var ALERT_INIT_HEIGHT:int=200;
		
		/**
		 *LTrace信息窗口的默认快捷键， 配合ctrl使用。（建议自行修改）
		 */
		public static var LTRACE_HOTKEY:uint=120;//F9
		/**
		 *组件装饰资源池最大实例数, （建议自行修改）
		 */
		public static var ASSET_POOL_INSTANCE_MAX:int = 15;
		
	}
}