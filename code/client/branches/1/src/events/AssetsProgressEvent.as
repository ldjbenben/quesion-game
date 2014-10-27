package events
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class AssetsProgressEvent extends ProgressEvent
	{
		/**
		 * 某项加载完成事件
		 */
		public static const ONE_COMPLETE:String = "one_complete";
		/**
		 * 资源总数
		 */
		public var numTotal:int;
		/**
		 * 已经加载完的资源数
		 */
		public var numLoaded:int;
		
		public function AssetsProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}