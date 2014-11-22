package application.config
{
	import application.components.MySocketConnector;
	import application.views.HallView;
	import application.views.LoadingView;
	import application.views.LoginView;
	
	import flash.utils.Dictionary;

	public class ApplicationConfig
	{
		public static function config():Object
		{
			return {
				"charset":"utf-8",
				"views":views(),
				"components":components()
			};
		}
		
		private static function components():Dictionary 
		{
			var components:Dictionary = new Dictionary();
			
			components["assetsLoader"] = {"assetsFile":"assets/assets.xml"};
//			components["connector"] = {"classname":MySocketConnector, "host":"192.168.1.149", "port":9999};
			components["connector"] = {"classname":MySocketConnector, "host":"192.168.1.155", "port":9999};
			components["message"] = {"assetId":1};
			
			return components;
		}
		
		private static function views():Dictionary
		{
			var views:Dictionary = new Dictionary();
			
			views["loading"] = LoadingView;
			views["main"] = HallView;
			views["login"] = LoginView;
			views["hall"] = HallView;
			
			return views;
		}
	}
}