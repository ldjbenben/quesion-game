package benben.base
{
	import benben.display.Loading;
	import benben.net.AssetsLoader;
	import benben.net.CustomSocket;
	import benben.net.IAssetsLoading;
	
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
		private var _socket:CustomSocket = null;
		private var _componentsConfig:Dictionary;
		private var _components:Dictionary;
		private var _loading:Loading;
		
		public function Application(stage:Sprite, configFile:String)
		{
			_componentsConfig = new Dictionary();
			_components = new Dictionary();
			_stage = stage;
			
			// 注册核心组件
			registerCoreComponents();
			
			// 加载配置文件
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(configFile);
			loader.addEventListener(Event.COMPLETE, configirue);
			loader.load(request);
		}
		
		protected function configirue(event:Event):void
		{
			var data:XML = new XML(event.target.data);
			var components:Dictionary = new Dictionary();
			
			for each(var component:XML in data.components.component)
			{
				var config:Dictionary = new Dictionary();
				var classname:String = String(component.@classname);
				
				if(classname)
				{
					config["classname"] = String(component.@classname);
				}
				
				for each(var property:XML in component.property)
				{
					var d:Dictionary = new Dictionary();
					var type:String = String(property.@type);
					var attNamesList:XMLList = property.attributes();
					
					for (var i:int = 0; i < attNamesList.length(); i++)
					{
						d[String(attNamesList[i].name())] = String(attNamesList[i]);
					} 

					config[String(property.@name)] = d;
				}
				components[String(component.@id)] = config;
			}
			
			registerComponents(components);
			
			assetsLoader.addAssetsFile(data.assets.toString());
			assetsLoader.addEventListener(Event.COMPLETE, assetsLoadComplete);
			assetsLoader.load();
			_stage.addChild(assetsLoader.loading);
		}
		
		/**
		 * 注册核心组件
		 */
		protected function registerCoreComponents():void
		{
			var components:Dictionary = new Dictionary();
			
			components["assetsLoader"] = new Dictionary();
			components["assetsLoader"]['classname'] = "benben.net.AssetsLoader"; 
			
			components["viewManager"] = new Dictionary();
			components["viewManager"]['classname'] = "benben.base.ViewManager";
			
			registerComponents(components);
		}
		
		protected function registerComponents(components:Dictionary):void
		{
			for(var key:String in components)
			{
				registerComponent(key, components[key]);
			} 
		}
		
		protected function registerComponent(id:String, config:Dictionary):void
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
		public function getComponent(id:String):Component
		{
			if(!_components.hasOwnProperty(id))
			{
				if(_componentsConfig.hasOwnProperty(id))
				{
					_components[id] = createComponent(_componentsConfig[id]);	
				}
			}
			
			return _components[id];
		}
		
		protected function createComponent(config:Dictionary):Component
		{
			var obj:Class = getDefinitionByName(config["classname"]) as Class;
			var component:Object = (new obj());
			
			delete config["classname"];
			
			for each(var item:Dictionary in config)
			{
				if(item['type'] == "class")
				{
					var value:Class = getDefinitionByName(item["classname"]) as Class;
					component[item["name"]] = (new value());
				}
				else
				{
					component[item["name"]] = item["value"];
				}
			}
			
			return component as Component;
		}
		
		public function run():void
		{
			//var ClassReference:Class = getDefinitionByName("display.scene."+this._defaultScene+"Scene") as Class;
			//var ClassReference:Class = getDefinitionByName("display.scene.") as Class;
			//var instance:Scene = new ClassReference() as Scene;
		//	_scenes["default"] = new _defaultScene();
			//_stage.addChild(_scenes["default"]);
		}
		
		private function assetsLoadComplete(event:Event):void
		{
			trace("load complete");
		}
		
		public function get assetsLoader():AssetsLoader
		{
			return getComponent("assetsLoader") as AssetsLoader;
		}
		
		public function get viewManager():ViewManager
		{
			return getComponent("viewManager") as ViewManager;
		}
		
		public function get socket():CustomSocket
		{
			if(null == _socket)
			{
				_socket = new CustomSocket("192.168.1.155", 2333);
			}
			return _socket;
		}
		
	}
}