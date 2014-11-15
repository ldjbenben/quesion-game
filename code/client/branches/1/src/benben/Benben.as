package benben
{
	import benben.base.Application;
	import benben.base.Stage;
	
	import flash.display.Sprite;

	public class Benben
	{
		private static var _app:Application = null;
		
		public function Benben()
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
		public static function createApplication(stage:Stage, config:Object):Application
		{
			if(null === _app)
			{
				_app = new Application(stage, config);
			}
			return _app;
		}
	}
}