package application.display.button
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class SimpleButton extends Sprite
	{
		protected var _defaultColor:uint = 0x00FFFF;
		protected var _mouseOverColor:uint = 0x00FFFF;
		protected var _title:String;
		
		public function SimpleButton(width:uint, height:uint)
		{
			super();
			
			this.buttonMode = true;
			this.graphics.beginFill(_defaultColor);
			this.graphics.drawRect(0, 0, width,height);
			this.graphics.endFill();
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function set title(value:String):void
		{
			this._title = value;
			var txt:TextField = new TextField();
			txt.text = value;
			txt.autoSize = TextFieldAutoSize.LEFT;
			addChild(txt);
			txt.selectable = false;
			txt.x = (this.width - txt.width)/2;
			txt.y = (this.height - txt.height)/2;
		}
		
		protected function onMouseOver(evt:MouseEvent):void
		{
			this.graphics.beginFill(_mouseOverColor);
			this.graphics.drawRect(0, 0, width,height);
			this.graphics.endFill();
		}
		
		protected function onMouseOut(evt:MouseEvent):void
		{
			this.graphics.beginFill(_defaultColor);
			this.graphics.drawRect(0, 0, width,height);
			this.graphics.endFill();
		}
	}
}