package application.events
{
	import flash.events.Event;
	
	public class SeatEvent extends Event
	{
		public static const CHOICE:String = "choice_seat";
		
		private var _postion:int = 0;
		private var _tableId:int = 0;
		
		public function SeatEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public function get tableId():int
		{
			return _tableId;
		}

		public function set tableId(value:int):void
		{
			_tableId = value;
		}

		public function set postion(value:int):void
		{
			_postion = value;
		}

		public function get postion():int
		{
			return _postion;
		}

	}
}