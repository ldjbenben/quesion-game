package benben.net
{
	import benben.base.Component;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	public class CustomSocket extends Component
	{
		private var _socket:Socket;
		private var response:String;
		private var _host:String;
		private var _port:int;
		private var _connected:Boolean;
		
		public function CustomSocket()
		{
			super();
		}
		
		public function connect():void
		{
//			configListeners();
			_socket.connect(_host, _port);
		}
		/*
		private function configListeners():void
		{
			addEventListener(Event.CLOSE, closeHandler);
			addEventListener(Event.CONNECT, connectHandler);
			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		private function writeln(str:String):void
		{
			str += "\n";
			try
			{
				writeUTFBytes(str);
			}
			catch(e:IOError)
			{
				trace(e);
			}
		}
		
		private function sendRequest():void
		{
			trace("连接服务器成功");
			writeByte(0x01);
			writeByte(0x00);
			writeByte(0x18);
			writeByte(0x00);
			writeUTF("hello 服务器!");
			flush();
		}
		
		private function readResponse():void
		{
			var str:String = readUTFBytes(bytesAvailable);
			trace(str);
			response += str;
		}
		
		private function closeHandler(event:Event):void
		{
			trace("closeHandler:" + event);
			super.close();
		}
		
		private function connectHandler(event:Event):void {
			trace("connectHandler: " + event);
			sendRequest();
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function socketDataHandler(event:ProgressEvent):void {
			trace("socketDataHandler: " + event);
			readResponse();
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

*/
	}
}
























