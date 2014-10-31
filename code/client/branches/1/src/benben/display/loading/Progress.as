package benben.display.loading
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
		private var _lineWidth:Number = 400;
		
		public function Progress()
		{
			_line = new Sprite();
			_line.graphics.beginFill(_bgcolor);
			_line.graphics.drawRect(0, 0, 1, 20);
			_line.graphics.endFill();
			addChild(_line);
			
			var format:TextFormat = new TextFormat();
			_titleField = new TextField();
			
			format.align = "center";
			_titleField.defaultTextFormat = format;
			_titleField.textColor = 0x0000FF;
			addChild(_titleField);
		}
		
		public function set percent(value:Number):void
		{
			_line.width = _lineWidth * value;
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

	}
}