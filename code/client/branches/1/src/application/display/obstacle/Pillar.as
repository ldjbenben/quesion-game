package application.display.obstacle
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Pillar extends Sprite
	{
		public function Pillar()
		{
			drawing();
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function drawing():void
		{
			this.buttonMode = true;
			this.graphics.beginFill(0x5555FF);
			this.graphics.drawRect(0, 0, 50,150);
			this.graphics.endFill();
			
			this.graphics.beginFill(0x0000FF);
			this.graphics.drawRect(10, 10, 40,140);
			this.graphics.endFill();
		}
		
		/*
		private function onEnterFrame(evt:Event):void
		{
			if(hitTestObj(
		}
		*/
	}
}