package wzq
{

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;


	public class Chessboard extends Sprite
	{
		public static const BLACK:String = "black";
		public static const WHITE:String = "white";

		private var _flag:Sprite;
		private var _data:Array;
		private var _chessmen:Array;
		private var _columns:int = 15;
		private var _rows:int = 15;
		private var _spacing:Number = 36.2;
		private var _ownerColor:String;
		private var _pre:String = WHITE;

		public function Chessboard()
		{
			init();
		}

		private function init():void
		{
			_chessmen = new Array(_rows);
			_data = new Array(_rows);

			for (var i:int = 0; i < _rows; i++)
			{
				_data[i] = new Array(_columns);
				_chessmen[i] = new Array(_columns);

				for (var j:int = 0; j < _columns; j++)
				{
					var mc:Chessman = new Chessman(i,j);

					_chessmen[i][j] = mc;
					_data[i][j] = 0;

					mc.x = _spacing * i;
					mc.y = _spacing * j;

					mc.addEventListener(MouseEvent.CLICK, onChessmanClick);
					mc.addEventListener(MouseEvent.MOUSE_OVER, onChessmanMouseOver);
					mc.addEventListener(MouseEvent.MOUSE_OUT, onChessmanMouseOut);

					addChild(mc);
				}
			}


			_flag = new Sprite();
			_flag.graphics.beginFill(0xff0000);
			_flag.graphics.drawCircle(0, 0, 10);
			_flag.graphics.endFill();
		}

		private function onChessmanClick(evt:MouseEvent):void
		{
			var chessman:Chessman = evt.target as Chessman;
			
			if (_pre != _ownerColor && _data[chessman.row][chessman.column] == 0)
			{
				if (_ownerColor == BLACK)
				{
					chessman.gotoAndStop(2);
					_data[chessman.row][chessman.column] = 1;
				}
				else
				{
					chessman.gotoAndStop(3);
					_data[chessman.row][chessman.column] = 2;
				}
				pre = _ownerColor;
			}
		}

		private function onChessmanMouseOver(evt:MouseEvent):void
		{
			var chessman:Chessman = evt.target as Chessman;
			
			if (_pre != _ownerColor && _data[chessman.row][chessman.column] == 0)
			{
				if (_ownerColor == BLACK)
				{
					chessman.gotoAndStop(6);
				}
				else
				{
					chessman.gotoAndStop(7);
				}
			}
		}

		private function onChessmanMouseOut(evt:MouseEvent):void
		{
			var chessman:Chessman = evt.target as Chessman;

			if (_pre != _ownerColor && _data[chessman.row][chessman.column] == 0)
			{
				if (_ownerColor == BLACK)
				{
					chessman.gotoAndStop(1);
				}
				else
				{
					chessman.gotoAndStop(1);
				}
			}
		}

		public function point(i:int, j:int):void
		{
			if (_data[i][j] == 0)
			{
				_data[i][j] = type;
			}
		}
		
		public function set ownerColor(value:String):void
		{
			_ownerColor = value;
		}
		
		public function get ownerColor():String
		{
			return _ownerColor;
		}
		
		public function set pre(value:String):void
		{
			_pre = value;
		}
		
		public function get pre():String
		{
			return _pre;
		}
	}

}