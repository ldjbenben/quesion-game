package application.components
{
	import application.config.ApiConfig;
	
	import benben.Benben;
	
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;

	public class ApiConnector
	{
		private var _data:Array;
		private var _callbackMap:Dictionary;
		private var _callbackCursor:int;
		
		public function ApiConnector()
		{
			_data = new Array();
			Benben.app.socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		public function set(key:String, value:*, type:String):void
		{
			_data.push({"value":value, "type":type});
		}
		
		public function send(apiname:String, callback:Function):void
		{
			var d:Array = new Array();
			var apiObj:Object = ApiConfig.get(apiname);
			
			_callbackMap[_callbackCursor++] = callback;

			d.push({"value":apiObj.id, "type":"int"});
			
			for(var i:int; i<_data.length; i++)
			{
				d.push(_data[i]);
			}
			
			Benben.app.socket.send(_data);
		}
		
		private function socketDataHandler(event:ProgressEvent):void 
		{
			var msgId:int = Benben.app.socket.socket.readInt();
			
			if(_callbackMap.hasOwnProperty(msgId))
			{
				_callbackMap[msgId]();
			}
		}
	}
}