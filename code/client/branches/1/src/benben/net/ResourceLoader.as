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
		private var _index:int;
		
		/**
		 * 资源配置xml文件地址
		 */
		public function ResourceLoader()
		{
		}
		
		public function addFile(url:String):void
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
		
		private function loadFile():void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function(event:Event):void{
				loadFile();
			});
			
			var request:URLRequest = new URLRequest(_queue[_index]);
			loader.load(request);
		}
		
	}
}