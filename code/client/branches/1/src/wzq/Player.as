package wzq {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	
	public class Player extends Sprite 
	{
		private var _head:String;
		private var _username:String;
		private var _secconds:int;
		
		private var __username_txt:TextField;
		public var username_txt:TextField;
		
		public function Player() 
		{
			initView();
		}
		
		private function initView():void
		{
			__username_txt = this.getChildByName("username_txt") as TextField;
		}
		
		public function set username(value:String):void
		{
			__username_txt.text = value;
		}
	}
	
}
