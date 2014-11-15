package application.views
{
	import benben.Benben;
	import benben.net.TransferDataType;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	

	public class LoginView extends BaseView
	{
		private var _loginWindow:Sprite;
		
		override public function init():void
		{
			super.init();
			
			_loginWindow = Benben.app.assetsLoader.getSwf("loginWindow");
			_loginWindow.addEventListener("login", onLoginButtonClick);
			
//			Benben.app.connector.addParam("nickname", "12test", TransferDataType.STRING);
//			Benben.app.connector.request("userLogin", testResponse);
			addChild(_loginWindow);
		}
		
		override public function enter():void
		{
		}
		
		private function onLoginButtonClick(evt:Object):void
		{
			//removeChild(_startButton);
			//run();
			//Benben.app.connector.addParam("uid", 1, TransferDataType.INT);
			Benben.app.connector.addParam("nickname", evt.nickname, TransferDataType.STRING);
			Benben.app.connector.request("userLogin", testResponse); 
			/*
			Benben.app.socket.writeInt(2);
			Benben.app.socket.writeInt(100);
			Benben.app.socket.writeInt(200);
			Benben.app.socket.writeInt(300);
			Benben.app.socket.sendRequest(2, testResponse); 
			//set(key, value, );
			*/
		}
		
		private function testResponse(bytes:ByteArray):void
		{
			//var code:int = bytes.readInt();
			//var a:int = bytes.readInt();
			trace("username:"+bytes.readUTF());
			Benben.app.viewManager.jump("hall");
		}
		
	}
}