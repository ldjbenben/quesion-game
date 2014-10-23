package application.display.player
{
	import flash.display.Sprite;

	public class Player extends Sprite
	{
		public function Player()
		{
			this.graphics.beginFill(0x00FF00);
			this.graphics.drawEllipse(0, 0, 20,20);
			this.graphics.endFill();
		}
	}
}