package benben.events
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class AssetsProgressEvent extends Event
	{
		/**
		 * 某个资源文件加载完成事件
		 */
		public static const PROGRESS:String = "progress";
		/**
		 * 某个资源文件开始加载事件
		 */
		public static const ONE_START:String = "one_start";
		/**
		 * 当前资源文件已经加载的字节数
		 */
		public var bytesLoaded:Number;
		/**
		 * 当前资源文件总字节数
		 */
		public var bytesTotal:Number;
		/**
		 * 已经加载完的资源数
		 */
		public var numLoaded:int;
		/**
		 * 资源总数
		 */
		public var numTotal:int;
		/**
		 * 当前资源名称
		 */
		public var title:String;
		
		
		public function AssetsProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}