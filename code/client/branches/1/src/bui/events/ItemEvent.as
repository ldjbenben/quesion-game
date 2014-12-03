package bui.events
{
	import flash.events.Event;
	
	public class ItemEvent extends Event
	{
		public static const CLICK:String = "click";
		
		public function ItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}