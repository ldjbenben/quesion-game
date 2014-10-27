package
{
	import application.views.BaseView;
	import benben.Wolf;
	import flash.display.Sprite;
	
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