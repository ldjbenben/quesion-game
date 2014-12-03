package bui.base
{
	import flash.display.Sprite;
	
	public class Area extends Sprite
	{
		public function Area(w:Number, h:Number)
		{
			graphics.beginFill(0xff00ff, 1);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
	}
}