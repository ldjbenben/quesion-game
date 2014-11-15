package application.display.login
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public var nickname:String;
		
		public function LoginEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}