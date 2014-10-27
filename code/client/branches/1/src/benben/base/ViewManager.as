package benben.base
{
	import application.views.BaseView;
	
	import benben.utils.StringHelper;
	
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;

	public class ViewManager extends Component
	{
		/**
		 * 舞台对象引用
		 */
		private var _stage:Sprite;
		/**
		 * 视图集合
		 */
		private var _viewsObj:Object = {};
		/**
		 * 当前视图ID
		 */
		private var _currentView:String;
		/**
		 * 默认视图ID
		 */
		public var defaultView:String;
		
		public function ViewManager(stage:Sprite)
		{
			_stage = stage;
//			_scenes = scenes;
//			_viewsObj[defaultId] = (new _scenes[defaultId]) as Scene;
//			_currentScene = defaultId;
//			_viewsObj[defaultId].init();
//			_viewsObj[defaultId].enter();
//			_stage.addChild(_viewsObj[defaultId]);
		}
		
		public function jump(id:String):void
		{
			if(!_viewsObj.hasOwnProperty(id))
			{
				_viewsObj[id] = this.createView(id);
				if(_currentView)
				{
					_viewsObj[_currentView].out();
				}
				this._stage.removeChild(_viewsObj[id]);
				_viewsObj[id].init();
			}
			else
			{
				if(_currentView)
				{
					_viewsObj[_currentView].out();
				}
			}
			
			_stage.addChild(_viewsObj[id]);
			_viewsObj[id].enter();
			_currentView = id;
		}
		
		private function createView(id:String):BaseView
		{
			var view:Object = getDefinitionByName("application.views."+StringHelper.ucword(id)+"View");
			
			if(!(view is BaseView))
			{
				return null;
			}
			
			return (view as BaseView);
		}
	}
}