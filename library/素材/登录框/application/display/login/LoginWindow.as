package application.display.login
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class LoginWindow extends Sprite
	{
		public var nickname_txt:TextField;
		public var login_btn:SimpleButton;
		
		public function LoginWindow()
		{
			nickname_txt.border = true;
			nickname_txt.background = true;
			nickname_txt.backgroundColor = 0xffffff;
			
			login_btn.addEventListener(MouseEvent.CLICK, onLoginBtnClick);
		}
		
		private function onLoginBtnClick(evt:MouseEvent):void
		{
			var loginEvt:LoginEvent = new LoginEvent("login");
			
			loginEvt.nickname = nickname_txt.text;

			dispatchEvent(loginEvt);
		}
	}
}