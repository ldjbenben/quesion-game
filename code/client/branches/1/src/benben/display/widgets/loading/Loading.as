package benben.display.widgets.loading
{
	import benben.display.widgets.IWidget;
	import benben.display.widgets.Widget;
	import benben.net.IAssetsLoading;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Loading extends Sprite implements IAssetsLoading, IWidget
	{
		private var _grogressWidth:Number = 500;
		private var _progressHeight:Number = 30;
		protected var _progressFile:Progress;
		protected var _progressFiles:Progress;
		private var _percent1:Number;
		private var _percent2:Number;
		private var _bgFile:String;
		
		/*
		public function Loading(params:Object)
		{
			if(params.hasOwnProperty("progressWidth"))
			{
				_grogressWidth = params.progressWidth;
			}
			
			if(params.hasOwnProperty("progressHeight"))
			{
				_progressHeight = params.progressHeight;
			}
			
			paint();
		}
		*/
		public function run():void
		{
			paint();
		}
		
		protected function paint():void
		{
			var loader:Loader = new Loader;
			var request:URLRequest = new URLRequest(_bgFile);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(evt:Event):void{
				var data:BitmapData = new BitmapData(800, 600);
				data.draw(evt.target.content);
				var img:Bitmap = new Bitmap(data);
				addChild(img);
				
				_progressFile = new Progress();
				addChild(_progressFile);
				_progressFile.y = 560;
				
				_progressFiles = new Progress();
				addChild(_progressFiles);
				_progressFiles.y = _progressFile.y + _progressFile.height + 5;
			});
			
			loader.load(request);
		}
		
		
		
		public function complete():void
		{
			// TODO Auto Generated method stub
			_progressFiles.percent = 1;
		}
		
		public function updateProgress(bytesLoaded:Number, bytesTotal:Number, numLoaded:int, numTotal:int, title:String):void
		{
			_progressFile.percent = bytesLoaded/bytesTotal;
			_progressFile.title = title;
			_progressFiles.percent = numLoaded/numTotal;
		}

		public function get progressFile():Progress
		{
			return _progressFile;
		}

		public function get progressFiles():Progress
		{
			return _progressFiles;
		}

		public function set bgFile(value:String):void
		{
			_bgFile = value;
		}


	}
}