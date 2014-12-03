package application.config
{
	import application.components.MySocketConnector;
	import application.proxies.HallViewProxy;
	import application.views.HallView;
	import application.views.LoadingView;
	import application.views.LoginView;
	import application.views.RoomView;
	
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
//			components["connector"] = {"classname":MySocketConnector, "host":"192.168.1.101", "port":9999};
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
			views["hall_proxy"] = HallViewProxy;
			views["room"] = RoomView;
			
			return views;
		}
	}
}