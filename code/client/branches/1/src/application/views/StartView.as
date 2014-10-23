package application.views
{
	import benben.Wolf;
	
	import application.display.UIManager;
	import application.display.button.SimpleButton;
	import application.display.dialog.LoginDialog;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	public class StartView extends BaseView
	{
		private var url:String = "http://dev.kaixin.maimaicha.com/static/d/d/bg_5001.jpg";
		private var size:uint = 80;
		

		public function StartView()
		{
			super();
		}
		
		override public function init():void
		{
			super.init();
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			var request:URLRequest = new URLRequest(url);
			loader.x = size * numChildren;
			loader.load(request);
			//addChild(loader);
			
			
			var btn:SimpleButton = new SimpleButton(100,50);
			btn.x = 400;
			btn.y = 500;
			btn.addEventListener(MouseEvent.CLICK, startGame);
			addChild(btn);
			
			UIManager.showDialog(new LoginDialog(), this);
		}
		
		private function startGame(evt:Event):void
		{
			Wolf.app.viewManager.jump("game");
		}
		
		private function completeHandler(event:Event):void
		{
			var loader:Loader = Loader(event.target.loader);
			var image:Bitmap = Bitmap(loader.content);
			image.x = -300;
			image.y = -200;
			image.z = 1;
			//image.
			//addChildAt(image, 0);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("Unable to load image: " + url);
		}

		
	}
}