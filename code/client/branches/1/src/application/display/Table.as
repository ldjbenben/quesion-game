package application.display
{
	import application.display.items.Chessboard;
	import application.display.items.Seat;
	import bui.base.UIComponent;
	import bui.controls.HGroup;

	public class Table extends UIComponent
	{
		/**
		 * 坐位号
		 */
		private var _id:int;
		private var _player1:Seat;
		private var _player2:Seat;
		private var _chessboard:Chessboard;
		private var _status:int;
		private var _group:HGroup;
		
		
		public function Table(id:int, status:int)
		{
			this._id = id;
			_group = new HGroup();
			_player1 = new Seat();
			_player2 = new Seat();
			_chessboard = new Chessboard();
			
			_player1.tableId = id;
			_player2.tableId = id;
			this.status = status;
			
			_group.addElement(_player1);
			_group.addElement(_chessboard);
			_group.addElement(_player2);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			addChild(_group);
		}
		
		public function get status():int
		{
			return _status;
		}

		public function set status(value:int):void
		{
			if(value & 0x01)
			{
				if(value & 0x02)
				{
					_player1.statement = Seat.STATEMENT_GIRL;
				}
				else
				{
					_player1.statement = Seat.STATEMENT_BOY;
				}
			}
			else
			{
				_player1.statement = Seat.STATEMENT_NO_ONE;
			}
			
			if(value & 0x04)
			{
				if(value & 0x08)
				{
					_player2.statement = Seat.STATEMENT_GIRL;
				}
				else
				{
					_player2.statement = Seat.STATEMENT_BOY;
				}
			}
			else
			{
				_player2.statement = Seat.STATEMENT_NO_ONE;
			}
			
			
			if(status & 0x05)
			{
				_chessboard.statement = Chessboard.STATEMENT_BUSY;
			}
			else
			{
				_chessboard.statement = Chessboard.STATEMENT_EMPTY;
			}
		}

		public function get player1():Seat
		{
			return _player1;
		}

		public function get player2():Seat
		{
			return _player2;
		}


	}
}