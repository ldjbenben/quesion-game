package application.views
{
	import flash.events.MouseEvent;
	
	import application.display.Table;
	import application.events.SeatEvent;
	
	import bui.controls.List;
	
	
	public class HallView extends BaseView
	{
		private var _chessboards:List;
		private var _roomId:int;
		
		public function get chessboards():List
		{
			return _chessboards;
		}

		override public function init():void
		{
			super.init();
			
			_chessboards = new List();
			_chessboards.layout.columnWidth = 150;
			_chessboards.layout.columnCount = 4;
			_chessboards.layout.rowHeight = 50;
			_chessboards.layout.verticalGap = 50;
			_chessboards.layout.horizontalGap = 50;
			
			_chessboards.x = 100;
			_chessboards.y = 20;
			_chessboards.unscaleWidth = 200;
			_chessboards.unscaleHeight = 300;
//			_chessboards.alpha = 0.1;
			addChild(_chessboards);
		}
		
		override public function enter():void
		{
			 
		}
		
		public function initChessboards(list:Array):void
		{
			for(var i:int = 0; i < list.length; i++)
			{
				var t:Table = new Table(i, list[i]);
				
				t.player1.addEventListener(MouseEvent.CLICK, onPlayer1SeatClick);
				t.player2.addEventListener(MouseEvent.CLICK, onPlayer2SeatClick);
				
				_chessboards.addItem(t);
			}
		}
		
		private function onPlayer1SeatClick(evt:MouseEvent):void
		{
			var seatEvt:SeatEvent = new SeatEvent(SeatEvent.CHOICE);
			seatEvt.postion = 0;
			seatEvt.tableId = evt.currentTarget.tableId;
			dispatchEvent(seatEvt);
		}
		
		private function onPlayer2SeatClick(evt:MouseEvent):void
		{
			var seatEvt:SeatEvent = new SeatEvent(SeatEvent.CHOICE);
			seatEvt.postion = 1;
			seatEvt.tableId = evt.currentTarget.tableId;
			dispatchEvent(seatEvt);
		}
	}
}