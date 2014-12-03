package application.proxies
{
	import application.events.SeatEvent;
	import application.views.HallView;
	import application.views.RoomView;
	
	import benben.Benben;
	import benben.base.View;
	import benben.base.ViewProxy;
	import benben.net.TransferDataType;
	
	import flash.utils.ByteArray;
	

	public class RoomViewProxy extends ViewProxy
	{
		public static const NOT_READY:int = 0;
		public static const READY:int = 1;
		
		public function RoomViewProxy(view:View)
		{
			super(view);
		}
		
		override public function init():void
		{
			Benben.app.connector.registerServerCallback("updateTables", otherPoint);
			Benben.app.connector.request("enterRoom", enterRoomResponse);
		}
		
		private function otherPoint(bytes:ByteArray):void
		{
			var x:int = bytes.readByte();
			var y:int = bytes.readByte();
			var v:RoomView = _view as RoomView;
			v.room.chessboard.point(x, y);
		}
		
		private function enterRoomResponse(bytes:ByteArray):void
		{
			var v:RoomView = _view as RoomView;
			var status:int = bytes.readByte();
			var mySide:int = bytes.readByte();
			var me:Object = {"ready":0, "name":""};
			var other:Object = {"ready":0, "name":""};
			
			if(status == 0)
			{
				me.ready = bytes.readByte();
				me.name = bytes.readUTF();
				
				other.ready = bytes.readByte();
				other.name = bytes.readUTF();
			}
			
			v.room.playerInfo(1,me);
			v.room.playerInfo(2,other);
		}
	}
}