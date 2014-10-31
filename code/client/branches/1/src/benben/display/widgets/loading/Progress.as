package benben.display.widgets.loading
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Progress extends Sprite
	{
		protected var _total:Number;
		protected var _num:Number;
		protected var _title:String;
		protected var _titleField:TextField;
		private var _bgcolor:int = 0x00ff00;
		private var _line:Sprite;
		private var _lineWidth:Number = 500;
		private var _lineHeight:Number = 20;
		
		
		public function Progress()
		{
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, _lineWidth, _lineHeight);
			graphics.endFill();
			
			_line = new Sprite();
			_line.graphics.beginFill(_bgcolor);
			_line.graphics.drawRect(0, 0, 1, _lineHeight-2);
			_line.graphics.endFill();
			_line.visible = false;
			_line.x = 1;
			_line.y = 1;
			addChild(_line);
			
			var format:TextFormat = new TextFormat();
			_titleField = new TextField();
			
			format.align = "center";
			_titleField.defaultTextFormat = format;
			_titleField.textColor = 0x0000FF;
			_titleField.height = _lineHeight;
			_titleField.width = _lineWidth;
			addChild(_titleField);
		}
		
		public function set percent(value:Number):void
		{
			_line.width = (_lineWidth-2) * value;
			_line.visible = true;
		}
		
		public function set title(value:String):void
		{
			_titleField.text = value;
		}

		public function set lineWidth(value:Number):void
		{
			_lineWidth = value;
			_titleField.width = value;
		}

		public function get lineHeight():Number
		{
			return _lineHeight;
		}

		public function set lineHeight(value:Number):void
		{
			_lineHeight = value;
		}

		public function set bgcolor(value:int):void
		{
			_bgcolor = value;
		}


	}
}