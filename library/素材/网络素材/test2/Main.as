package  {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class Main extends Sprite {
		
		
		public function Main() 
		{
			var circle:Sprite = new Sprite();
				circle.graphics.beginFill(0xFFCC00);
				circle.graphics.drawRect(0, 0, 200, 200);
				circle.scrollRect = new Rectangle(0, 0, 200, 100);
				addChild(circle);
				
				circle.addEventListener(MouseEvent.CLICK, clicked);
				
				function clicked(event:MouseEvent):void {
					var rect:Rectangle = event.target.scrollRect;
					rect.y += 5;
					event.target.scrollRect = rect;
				}

		}
	}
	
}
