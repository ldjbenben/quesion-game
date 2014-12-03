package bui.skins.ben
{
	import bui.skins.ProgrammaticSkin;
	
	public class ScrollTrackSkin extends ProgrammaticSkin
	{
		public function ScrollTrackSkin()
		{
			_unscaleWidth = 20;
			_unscaleHeight = 200;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			graphics.beginFill(0x990099);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
		}
	}
}