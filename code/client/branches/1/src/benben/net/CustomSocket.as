package benben.net
{
	import benben.base.Component;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.Dictionary;
	
	public class CustomSocket extends Component
	{
		private var _socket:Socket;
		private var response:String;
		private var _host:String;
		private var _port:int;
		private var _connected:Boolean;
		
		/**
		 * 请求与回调函数映射集
		 */
		private var _requestMap:Dictionary;
		
		public function CustomSocket()
		{
			_socket = new Socket();
			_requestMap = new Dictionary();
		}
		
		public function connect():void
		{
			configListeners();
			_socket.connect(_host, _port);
		}
		
		private function configListeners():void
		{
			_socket.addEventListener(Event.CLOSE, closeHandler);
			_socket.addEventListener(Event.CONNECT, connectHandler);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		private function writeln(str:String):void
		{
			str += "\n";
			try
			{
				_socket.writeUTFBytes(str);
			}
			catch(e:IOError)
			{
				trace(e);
			}
		}
		
		public function send(data:Array):void
		{
			for(var i:int; i<data.length; i++)
			{
				var obj:Object = data[i];
				switch(obj[i])
				{
					case 'int':
						_socket.writeInt(obj["value"]);
						break;
				}
			}
			
			_socket.flush();
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
		
		private function socketDataHandler(event:ProgressEvent):void 
		{
			dispatchEvent(event);
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
























