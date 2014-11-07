package
{
	import application.config.ApplicationConfig;
	import application.views.BaseView;
	import application.views.LoadingView;
	
	import benben.Benben;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	[SWF(width=800, height=600)]
	
	public class Main extends Sprite
	{
		private var _startScene:BaseView;
		private var _GameScene:BaseView;
		
		public function Main()
		{
			var a:String = "a中国";
			trace("len:"+a.length+"  "+a.charCodeAt(0))
			Benben.createApplication(this, ApplicationConfig.config()).run();
		}
	}
}