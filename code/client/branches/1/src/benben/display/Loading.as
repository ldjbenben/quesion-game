package benben.display
{
	import benben.display.loading.Progress;
	import benben.net.IAssetsLoading;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Loading extends Sprite implements IAssetsLoading
	{
		private var _grogressWidth:Number = 500;
		private var _progressHeight:Number = 30;
		
		private var _numTotal:int;
		private var _numLoaded:int;
		protected var _progress1:Progress;
		protected var _progress2:Progress;
		private var _percent1:Number;
		private var _percent2:Number;
		
		
		public function Loading()
		{
			super();
			paint();
			
			_progress1 = new Progress();
			_progress1.lineWidth = 500;
			addChild(_progress1);
			
			_progress2 = new Progress();
			_progress2.lineWidth = 500;
			_progress2.y = _progress1.height + 20;
			addChild(_progress2);
			
			this.addEventListener(Event.ENTER_FRAME, function():void{
			});
		}
		
		protected function paint():void
		{
			this.graphics.beginFill(0x000);
			this.graphics.drawRect(0, 0, _grogressWidth, _progressHeight);
			this.graphics.endFill();
		}
		
		public function complete():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function set numTotal(value:int):void
		{
			_numTotal = value;
		}
		
		public function updateProgress(bytesLoaded:Number, bytesTotal:Number, title:String):void
		{
			_progress1.percent = bytesLoaded/bytesTotal;
//			_w = _grogressWidth * bytesLoaded/bytesTotal;
			_progress1.title = title;
		}
		
		public function oneComplete():void
		{
			_progress2.percent = (++_numLoaded)/_numTotal;
		}
	}
}