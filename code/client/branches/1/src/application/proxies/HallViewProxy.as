package application.proxies
{
	import application.events.SeatEvent;
	import application.views.HallView;
	
	import benben.Benben;
	import benben.base.View;
	import benben.base.ViewProxy;
	import benben.net.TransferDataType;
	
	import flash.utils.ByteArray;
	

	public class HallViewProxy extends ViewProxy
	{
		public function HallViewProxy(view:View)
		{
			super(view);
		}
		
		override public function init():void
		{
			Benben.app.connector.registerServerCallback("updateTables", updateTables);
			Benben.app.connector.request("getTables", getTablesResponse);
			view.addEventListener(SeatEvent.CHOICE, onChoiceSeat);
		}
		
		private function onChoiceSeat(evt:SeatEvent):void
		{
			Benben.app.connector.addParam("roomId", 0, TransferDataType.INT);
			Benben.app.connector.addParam("tableId", evt.tableId, TransferDataType.INT);
			Benben.app.connector.addParam("position", evt.postion, TransferDataType.BYTE);
			Benben.app.connector.request("sitdown", sitdownResponse);
		}
		
		private function updateTables(bytes:ByteArray):void
		{
			var ret:int = bytes.readInt();
			var tableId:int = bytes.readInt();
			var status:int = bytes.readByte();
			var v:HallView = _view as HallView;
			v.chessboards.getItem(tableId).status = status;
		}
		
		private function getTablesResponse(bytes:ByteArray):void
		{
			var len:int = bytes.readShort();
			var list:Array = new Array();
			
			for(var i:int = 0; i < len; i++)
			{
				list.push(bytes.readByte());
			}
			
			var viewObj:HallView = view as HallView;
			viewObj.initChessboards(list);
		}
		
		private function sitdownResponse(bytes:ByteArray):void
		{
			Benben.app.viewManager.jump("room");
		}
		
	}
}