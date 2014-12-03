package wzq {
	import flash.display.MovieClip;
	
	public class Chessman extends MovieClip
	{
		private var _status:int = 0;
		private var _row:int;
		private var _column:int;
		
		public function Chessman(row:int, column:int) 
		{
			_row = row;
			_column = column;
			gotoAndStop(1);
		}
		
		public function set status(value:int):void
		{
			_status = value;
			gotoAndStop(_status);
			trace(value);
		}
		
		public function get row():int
		{
			return _row;
		}
		
		public function get column():int
		{
			return _column;
		}

	}
	
}
