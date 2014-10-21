package benben.net
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class CustomSocket extends Socket 
	{
		private var response:String;
		
		public function CustomSocket(host:String = null, port:uint = 0) 
		{
			super();
			configureListeners();
			if (host && port)  
			{
				super.connect(host, port);
			}
		}
		
		private function configureListeners():void 
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
			trace("sendRequest");
			response = "";
			this.writeShort(1);
			this.writeShort(0xa);
			this.writeShort(0xb);
			this.writeByte(0x40);
			this.writeByte(0x41);
			this.writeByte(0x42);
//			this.writeShort(1);
			this.writeByte(0);
			//this.writeMultiByte("hello world", "utf8");
			//writeln("GET /");
			flush();
		}
		
		private function readResponse():void
		{
			var str:String = readUTFBytes(bytesAvailable);
			response += str;
		}
		
		private function closeHandler(event:Event):void
		{
			trace("closeHandler: " + event);
			trace(response.toString());
		}
		
		private function connectHandler(event:Event):void 
		{
			trace("connectHandler: " + event);
			sendRequest();
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void 
		{
			trace("ioErrorHandler: " + event);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void 
		{
			trace("securityErrorHandler: " + event);
		}
		
		private function socketDataHandler(event:ProgressEvent):void 
		{
			trace("socketDataHandler: " + event);
			readResponse();
		}
	}

}