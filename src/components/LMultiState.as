package components
{
	import core.ImultiState;
	
	import vos.ChildStyleHashVO;
	
	/**
	 *@author swellee
	 *2013-4-10
	 *
	 */
	public class LMultiState extends LComponent implements ImultiState
	{
		protected var _stateStyleHash:Vector.<ChildStyleHashVO>;
		/**用于表现状态的内部组件*/
		protected var stateUI:LComponent;
		
		public function LMultiState()
		{
			super();
		}
		override protected function init():void
		{
			super.init();
			initStateUI();
			initStateStyleHash();
		}
		protected function initStateUI():void
		{
			if(!stateUI)
			{
				stateUI=new LComponent();
				addChild(stateUI);
			}
		}
		
		/**
		 * IMultiState 初始化时会调用此方法，以生成此原始的ChildStyleHashVO序列 
		 */
		protected function initStateStyleHash():void
		{
			_stateStyleHash=new Vector.<ChildStyleHashVO>();
		}
		public function get stateStyleHash():Vector.<ChildStyleHashVO>
		{
			return _stateStyleHash;
		}
		
		public function showState(stateType:String=null):void
		{
			//如果所需的样式为null,则使用状态样式表里的第一个状态样式
			stateUI.style=getStateStyle(stateType)||stateStyleHash[0].childStyle;
		}
		
		public function getStateStyle(stateType:String):String
		{
			if(stateType)
			{
				for ( var i:int=0;i< stateStyleHash.length;i++) 
				{
					var childStyleVo:ChildStyleHashVO=stateStyleHash[i];
					if(childStyleVo.childName==stateType)
						return childStyleVo.childStyle;
				}
			}
			return null;
		}
		
		override public function set width(value:Number):void
		{
			super.width=value;
			stateUI.width=value;
		}
		override public function set height(value:Number):void
		{
			super.height=value;
			stateUI.height=value;
		}
		
		override public function dispose():void
		{
			_stateStyleHash=null;
			super.dispose();
		}
	}
}