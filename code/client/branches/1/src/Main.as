package
{
	import application.config.ApplicationConfig;
	import application.views.BaseView;
<<<<<<< HEAD
	import application.views.LoadingView;
	
	import benben.Benben;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
=======
	import application.views.GameView;
	import application.views.StartView;
	
	import benben.Wolf;
	
	import com.adobe.crypto.MD5;
	
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
>>>>>>> origin/master
	
	[SWF(width=800, height=600)]
	
	public class Main extends Sprite
	{
		private var _startScene:BaseView;
		private var _GameScene:BaseView;
		
		public function Main()
		{
			Benben.createApplication(this, ApplicationConfig.config()).run();
		}
	}
}