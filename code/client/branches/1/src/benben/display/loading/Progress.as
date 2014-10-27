package benben.display.loading
{
	import flash.display.Sprite;
	
	public class Progress extends Sprite
	{
		protected var _total:Number;
		protected var _num:Number;
		
		public function Progress(width:Number)
		{
			this.graphics.beginFill(0x00ff00);
			this.graphics.drawRect(0, 0, 1, 20);
			this.graphics.endFill();
		}
	}
}