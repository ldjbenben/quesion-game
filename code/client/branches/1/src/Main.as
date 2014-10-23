package
{
	import application.views.BaseView;
	import application.views.GameView;
	import application.views.StartView;
	
	import benben.Wolf;
	
	import com.adobe.crypto.MD5;
	
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	[SWF(width=800, height=600)]
	
	public class Main extends Sprite
	{
		private var _startScene:BaseView;
		private var _GameScene:BaseView;
		
		public function Main()
		{
			Wolf.createApplication(this, "./data/application.xml").run();
		}
	}
}