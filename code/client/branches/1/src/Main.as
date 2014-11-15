package
{
	import application.config.ApplicationConfig;
	import application.views.BaseView;
	import application.views.LoadingView;
	
	import benben.Benben;
	import benben.base.Stage;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	[SWF(width=900, height=600)]
	
	public class Main extends Stage
	{
		private var _startScene:BaseView;
		private var _GameScene:BaseView;
		
		public function Main()
		{
			_stage_width = 900;
			_stage_height = 600;
			var a:String = "a中国";
			trace("len:"+a.length+"  "+a.charCodeAt(0))
			Benben.createApplication(this, ApplicationConfig.config()).run();
		}
	}
}