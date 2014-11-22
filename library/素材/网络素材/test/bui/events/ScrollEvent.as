package bui.events
{
	import flash.events.Event;
	
	public class ScrollEvent extends Event
	{
		public const SCROLL:String = "scroll";
		
		/**
		 * 滚动导致的滚动(内容)位置值的更改
		 */
		public var delta:Number;
		/**
		 * 运动方向
		 */
		public var direction:String;
		/**
		 * 新的(内容)滚动位置
		 */
		public var position:Number;
		
		public function ScrollEvent(bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(SCROLL, bubbles, cancelable);
		}
	}
}