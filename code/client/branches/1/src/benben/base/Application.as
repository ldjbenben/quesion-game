package benben.base
{
	import application.views.BaseView;
	
	import benben.net.CustomSocket;
	import benben.net.ResourceLoader;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	public class Application
	{
		private var _defaultScene:Class;
		private var _stage:Sprite;
		private var _resourceLoader:ResourceLoader;
		private var _viewManager:ViewManager;
		private var _socket:CustomSocket = null;
		
		public function Application(stage:Sprite, configFile:String)
		{
			_stage = stage;
			resourceLoader.addFile(configFile);
		}
		
		public function run():void
		{
			//var ClassReference:Class = getDefinitionByName("display.scene."+this._defaultScene+"Scene") as Class;
			//var ClassReference:Class = getDefinitionByName("display.scene.") as Class;
			//var instance:Scene = new ClassReference() as Scene;
		//	_scenes["default"] = new _defaultScene();
			//_stage.addChild(_scenes["default"]);
		}
		
		public function get resourceLoader():ResourceLoader
		{
			if(null == _resourceLoader)
			{
				_resourceLoader = new ResourceLoader();
			}
			return _resourceLoader;
		}
		
		public function get viewManager():ViewManager
		{
			return _viewManager;
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