package benben.net.connectors
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import application.config.ApiConfig;
	
	import benben.base.Component;
	import benben.net.TransferDataType;

	public class SocketConnector extends Component implements IConnector
	{
		private var _socket:Socket;
		private var _data:Array;
		private var _bytes:ByteArray;
		private var _callbackMap:Dictionary;
		private var _callbackCursor:int;
		private var _serverCallbackMap:Dictionary;
		private var _host:String;
		private var _port:int;
		private var _autoConnect:Boolean = true;
		private var _bytesNum:int;  // 内容数据字节长度(不包括信息头)
		/**
		 * 消息类型。0表示API回调，1表示服务器推送
		 */
		private var _msgType:int = 0;
		
		public function SocketConnector()
		{
			_socket = new Socket();
			_data = new Array();
			_bytes = new ByteArray();
			_callbackMap = new Dictionary();
			_serverCallbackMap = new Dictionary();
		}
		
		override public function init():void
		{
			configListeners();
			if(_autoConnect)
			{
				open();
			}
		}
		
		private function configListeners():void
		{
			_socket.addEventListener(Event.CLOSE, closeHandler);
			_socket.addEventListener(Event.CONNECT, connectHandler);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		private function open():void
		{
			if(!_socket.connected)
			{
				_socket.connect(_host, _port);
			}
		}
		
		public function addParam(key:String, value:*, type:String):void
		{
			_data.push({"value":value, "type":type});
			_bytesNum += sizeof(value, type);
		}
		/*
		public function getParam(key:String, type:String):*
		{
			var value:*;
			
			switch(type)
			{
				case TransferDataType.INT:
					value = _socket.readInt();
					break;
				case TransferDataType.STRING:
					value = _socket.readUTF();
					break;
			}
			
			return value;
		}
		*/
		/**
		 * 获取value所占字节数
		 */
		private function sizeof(value:*, type:String):int
		{
			var num:int = 0;
			
			switch(type)
			{
				case TransferDataType.INT:
					num = 4;
					break;
				case TransferDataType.STRING:
					num = value.length;
					break;
				case TransferDataType.BYTE:
					num = 1;
					break;
			}
			
			return num;
		}
		
		public function registerServerCallback(apiname:String, callback:Function):void
		{
			var apiObj:Object = ApiConfig.getClientApi(apiname);
			_serverCallbackMap[apiObj.id] = callback;
		}
		
		public function unregisterServerCallback(apiname:String):void
		{
			var apiObj:Object = ApiConfig.getClientApi(apiname);
			delete _serverCallbackMap[apiObj.id];
		}
		
		public function request(apiname:String, callback:Function):void
		{
			_bytes.clear();
			var d:Array = new Array();
			var apiObj:Object = ApiConfig.getServerApi(apiname);
			
			_callbackMap[_callbackCursor] = callback;
			
			_bytes.writeInt(apiObj.id);
			_bytes.writeInt(_callbackCursor);
			_bytes.writeInt(_bytesNum);
			
			_callbackCursor++;
			
			for(var i:int; i<_data.length; i++)
			{
				var obj:Object = _data[i];
				switch(obj.type)
				{
					case TransferDataType.INT:
						_bytes.writeInt(obj["value"]);
						break;
					case TransferDataType.STRING:
						_bytes.writeUTF(obj["value"]);
						break;
					case TransferDataType.BYTE:
						_bytes.writeByte(obj["value"]);
				}
			}
			
			_socket.writeBytes(_bytes);
			_socket.flush();
			reset();
		}
		
		private function reset():void
		{
			_data = [];
			_bytesNum = 0;
		}
		
		protected function socketDataHandler(event:ProgressEvent):void 
		{
			var type:int = _socket.readByte();
			var msgId:int = _socket.readInt();
			var bytes:ByteArray = new ByteArray();
			_socket.readBytes(bytes);
			
			if(type == 0)
			{
				if(beforeCallback(bytes))
				{
					if(_callbackMap.hasOwnProperty(msgId))
					{
						_callbackMap[msgId](bytes);
					}
				}
			}
			else
			{
				if(_serverCallbackMap.hasOwnProperty(msgId))
				{
					_serverCallbackMap[msgId](bytes);
				}
			}
		}
		
		protected function beforeCallback(bytes:ByteArray):Boolean
		{
			return true;
		}
		
		private function closeHandler(event:Event):void
		{
			trace("closeHandler:" + event);
			_socket.close();
		}
		
		private function connectHandler(event:Event):void {
			trace("connectHandler: " + event);
			//sendRequest();
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		public function get host():String
		{
			return _host;
		}
		
		public function set host(value:String):void
		{
			_host = value;
		}
		
		public function get port():int
		{
			return _port;
		}
		
		public function set port(value:int):void
		{
			_port = value;
		}
		
		public function get socket():Socket
		{
			return _socket;
		}
	}
}