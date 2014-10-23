package benben.net
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class ResourceLoader
	{
		/**
		 * 未加载的资源列表
		 */
		private var _queue:Array;
		/**
		 * 已加载完成的资源
		 */
		private var _assets:Dictionary;
		
		/**
		 * 资源配置xml文件地址
		 */
		public function ResourceLoader()
		{
		}
		
		public function addFile():void
		{
			
		}
		
		public function addAssetsFile(file:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, completeHandler);
			var request:URLRequest = new URLRequest(file);
			
			try
			{
				loader.load(request);
			}
			catch (error:Error)
			{
				trace("Unable to load requested document.");
			}
		}
		
		public function load():void
		{
			
		}
		
		private function loadFile(file:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, completeHandler);
			
			for each (var key in _queue)
			{ 
				var request:URLRequest = new URLRequest(_queue[key]);
				loader.load(request);
			} 
		}
		
		private function completeHandler(event:Event):void
		{
			var loader:URLLoader = URLLoader(event.target);
			trace("completeHandler: " + loader.data);
			
			var data:XML = loader.data as XML;
		}
		
	}
}