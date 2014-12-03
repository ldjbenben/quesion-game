package benben.base
{
	import application.views.BaseView;
	import application.views.LoadingView;
	
	import benben.Benben;
	import benben.utils.StringHelper;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	public class ViewManager extends Component
	{
		private var _stage:Sprite;
		/**
		 * 视图集合
		 */
		private var _viewsObj:Object = {};
		/**
		 * 视图代理集合
		 */
		private var _proxiesObj:Object = {};
		/**
		 * 当前视图ID
		 */
		private var _currentView:String;
		
		public function ViewManager()
		{
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
					this._stage.removeChild(_viewsObj[_currentView]);
				}
				
				_viewsObj[id].init();
				
				if(Benben.app.views.hasOwnProperty(id+"_proxy"))
				{
					_proxiesObj[id] = this.createViewProxy(id, _viewsObj[id]);
					_proxiesObj[id].init();
				}
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
		
		private function createViewProxy(id:String, view:BaseView):ViewProxy
		{
			var proxy:Object = new (getDefinitionByName("application.proxies."+StringHelper.ucword(id)+"ViewProxy"))(view);
			
			if(!(proxy is ViewProxy))
			{
				return null;
			}
			
			return (proxy as ViewProxy);
		}
		
		private function createView(id:String):BaseView
		{
			var view:Object = new (getDefinitionByName("application.views."+StringHelper.ucword(id)+"View"))();
			
			if(!(view is BaseView))
			{
				return null;
			}
			
			return (view as BaseView);
		}

		/**
		 * 舞台对象引用
		 */
		public function get stage():Sprite
		{
			return _stage;
		}

		/**
		 * @private
		 */
		public function set stage(value:Sprite):void
		{
			_stage = value;
		}

	}
}