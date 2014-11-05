package application.config
{
	import application.views.LoadingView;
	import application.views.MainView;
	
	import flash.utils.Dictionary;

	public class ApplicationConfig
	{
		public static function config():Object
		{
			return {
				"views":views(),
				"components":components()
			};
		}
		
		private static function components():Dictionary 
		{
			var components:Dictionary = new Dictionary();
			
			components["assetsLoader"] = {"assetsFile":"assets/assets.xml"};
			components["connector"] = {"host":"192.168.1.155", "port":9999};
			
			return components;
		}
		
		private static function views():Dictionary
		{
			var views:Dictionary = new Dictionary();
			
			views["loading"] = LoadingView;
			views["main"] = MainView;
			
			return views;
		}
	}
}