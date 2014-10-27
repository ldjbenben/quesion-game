package benben.display
{
	import benben.display.loading.Progress;
	import benben.net.IAssetsLoading;
	
	import flash.display.Sprite;
	
	public class Loading extends Sprite implements IAssetsLoading
	{
		private var _grogressWidth:Number = 500;
		private var _progressHeight:Number = 30;
		
		protected var _progress1:Progress;
		protected var _progress2:Progress;
		
		public function Loading()
		{
			super();
			
			_progress1 = new Progress(_grogressWidth);
			
			addChild(_progress1);
//			_progress1.width = 500;
//			_progress1.height = 20;
			
			_progress2 = new Progress(_grogressWidth);
			
			paint();
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
		
		public function set numLoaded(value:int):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function set numTotal(value:int):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function oneComplete():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function updateProgress(bytesLoaded:Number, bytesTotal:Number, name:String):void
		{
			// TODO Auto Generated method stub
//			_progress1.width = _grogressWidth * bytesLoaded/bytesTotal + 40;
			_progress1.width += 1;
		}
		
	}
}