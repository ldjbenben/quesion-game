package benben.base
{
	import benben.display.widgets.loading.Loading;
	import benben.net.AssetsLoader;
	import benben.net.IAssetsLoading;
	import benben.net.connectors.IConnector;
	import benben.net.connectors.SocketConnector;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	public class Application
	{
		private var _defaultScene:Class;
		private var _stage:Sprite;
		private var _assetsLoader:AssetsLoader;
		private var _viewManager:ViewManager;
		private var _connector:IConnector;
		private var _componentsConfig:Dictionary;
		private var _components:Dictionary;
		private var _views:Dictionary;
		private var _loading:Loading;
		private var _defaultView:String = "loading";
		
		public function Application(stage:Sprite, config:Object)
		{
			_componentsConfig = new Dictionary();
			_components = new Dictionary();
			_stage = stage;
			
			// 注册核心组件
			registerCoreComponents();
			
			// 配置
			configure(config);
		}
		
		public function run():void
		{
			viewManager.jump(_defaultView);
		}
		
		protected function configure(config:Object):void
		{
			registerComponents(config.components);
			registerViews(config.views);
		}
		
		private function registerViews(views:Dictionary):void
		{
			_views = views;
		}
		
		/**
		 * 注册核心组件
		 */
		protected function registerCoreComponents():void
		{
			var components:Dictionary = new Dictionary();

			components["assetsLoader"] = {"classname":benben.net.AssetsLoader};
			components["viewManager"] = {"classname":benben.base.ViewManager, "stage":_stage};
			components["connector"] = {"classname":benben.net.connectors.SocketConnector};
			
			registerComponents(components);
		}
		
		protected function registerComponents(components:Dictionary):void
		{
			for(var key:String in components)
			{
				registerComponent(key, components[key]);
			} 
		}
		
		protected function registerComponent(id:String, config:Object):void
		{
			if(_componentsConfig.hasOwnProperty(id))
			{
				for(var key:String in config)
				{
					_componentsConfig[id][key] = config[key];
				}
			}
			else
			{
				_componentsConfig[id] = config;
			}
		}
		
		/**
		 * 获取组件
		 */
		public function getComponent(id:String, createIfNull:Boolean=true):Component
		{
			if(!_components.hasOwnProperty(id))
			{
				if(createIfNull)
				{
					if(_componentsConfig.hasOwnProperty(id))
					{
						_components[id] = createComponent(_componentsConfig[id]);
						_components[id].init();
					}
				}
				else
				{
					return null;
				}
			}
			
			return _components[id];
		}
		
		protected function createComponent(config:Object):Component
		{
			//var obj:Class = getDefinitionByName(config["classname"]) as Class;
			var component:Object;
			var len:int = arguments.length;
			
			if(len == 1)
			{
				component = (new (config.classname)());
			}
			else if(len == 2)
			{
				component = (new (config.classname)(arguments[1]));
			}
			else if(len == 3)
			{
				component = (new (config.classname)(arguments[2], arguments[3]));
			}
			
			delete config["classname"];
			delete config["id"];
			
			for(var key:String in config)
			{
				component[key] = config[key];
			}

			return component as Component;
		}
		
		public function get assetsLoader():AssetsLoader
		{
			return getComponent("assetsLoader") as AssetsLoader;
		}
		
		public function get viewManager():ViewManager
		{
			return getComponent("viewManager") as ViewManager;
		}
		
		public function get connector():IConnector
		{
			return getComponent("connector") as IConnector;
		}

		
	}
}