package application.display.dialog
{
	import benben.net.CustomSocket;
	
	import benben.Benben;
	
	import application.display.button.SimpleButton;
	
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.ByteArray;

	public class LoginDialog extends Dialog
	{
		private var _borderWidth:Number = 2;
		private var _usernameField:TextField;
		private var _usernameInput:TextField;
		private var _passwordField:TextField;
		private var _passwordInput:TextField;
		private var _loginButton:SimpleButton;
		
		public function LoginDialog()
		{
			this.graphics.beginFill(0xffffff, 0.5);
			this.graphics.drawRoundRect(0, 0, 450, 350, 10, 10);
			this.graphics.endFill();
			
			this.graphics.beginFill(0x3e8e2e, 0.9);
			this.graphics.drawRoundRect(_borderWidth, _borderWidth, 450-(_borderWidth*2), 350-(_borderWidth*2), 10, 10);
			this.graphics.endFill();
			
			_usernameField = new TextField();
			_usernameField.height = 20;
			_usernameField.text = "用户名：";
//			_usernameField.width = 100;
			addChild(_usernameField);
			_usernameField.x = 100;
			_usernameField.y = 50;
			
			_usernameInput = new TextField();
			_usernameInput.height = 20;
			_usernameInput.type = "input";
			addChild(_usernameInput);
			_usernameInput.border = true;
			_usernameInput.borderColor = 0xffffff;
			_usernameInput.width = 100;
			_usernameInput.x = _usernameField.x + _usernameField.width + 10;
			_usernameInput.y = _usernameField.y;
			
			_passwordField = new TextField();
			_passwordField.text = "密码：";
			_passwordField.border = true;
//			_passwordField.width = 100;
			_passwordField.borderColor = 0xffffff;
			_passwordField.autoSize = TextFieldAutoSize.RIGHT;
			addChild(_passwordField);
			_passwordField.x = 100;
			_passwordField.y = _usernameField.y + _usernameField.height + 20;
			
			_passwordInput = new TextField();
			_passwordInput.type = "input";
			_passwordInput.height = 20;
			addChild(_passwordInput);
			_passwordInput.border = true;
			_passwordInput.borderColor = 0xffffff;
			_passwordInput.width = 100;
			_passwordInput.x = _passwordField.x + _passwordField.width + 10;
			_passwordInput.y = _passwordField.y;
			
			_loginButton = new SimpleButton(100, 50);
			_loginButton.title = "Login";
			addChild(_loginButton);
			
			_loginButton.addEventListener(MouseEvent.CLICK, onLoginButtonClick);
		}
		
		private function onLoginButtonClick(event:MouseEvent):void
		{
			trace("cdddd");
			Benben.app.socket.writeByte(0x02);
			Benben.app.socket.writeByte(0x00);
			Benben.app.socket.writeByte(0x01);
			Benben.app.socket.writeByte(0x00);
			Benben.app.socket.writeByte(0x21);
			Benben.app.socket.writeByte(0x00);
			Benben.app.socket.writeInt(10);
			Benben.app.socket.writeInt(100);
			Benben.app.socket.writeByte(50);
			Benben.app.socket.writeUTFBytes("hello world中国!");
			Benben.app.socket.writeByte(0x00);
			Benben.app.socket.writeByte(2);
			Benben.app.socket.flush();
		}
	}
}