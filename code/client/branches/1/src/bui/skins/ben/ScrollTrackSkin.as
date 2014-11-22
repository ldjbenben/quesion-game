package bui.skins.ben
{
	import bui.skins.ProgrammaticSkin;
	
	public class ScrollTrackSkin extends ProgrammaticSkin
	{
		
		
		public function ScrollTrackSkin()
		{
			_measureWidth = 20;
			_measureHeight = 300;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			trace(unscaledWidth + "," + _measureHeight);
			graphics.beginFill(0x990099);
			graphics.drawRect(0, 0, unscaledWidth, _measureHeight);
			graphics.endFill();
		}
	}
}