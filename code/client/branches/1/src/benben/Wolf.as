package benben
{
	import benben.base.Application;
	
	import flash.display.Sprite;

	public class Wolf
	{
		private static var _app:Application = null;
		
		public function Wolf()
		{
		}
		
		public static function get app():Application
		{
			return _app;
		}
		
		/**
		 * @param stage 舞台实例
		 * @param configFile xml配置文件位置
		 */
		public static function createApplication(stage:Sprite, configFile:String):Application
		{
			if(null === _app)
			{
				_app = new Application(stage, configFile);
			}
			return _app;
		}
	}
}