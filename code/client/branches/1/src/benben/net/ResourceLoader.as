package benben.net
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class ResourceLoader
	{
		/**
		 * 资源列表xml文件
		 */
		private var _files:Array;
		/**
		 * 未加载的资源列表
		 */
		private var _queue:Array;
		/**
		 * 已加载完成的资源
		 */
		private var _assets:Dictionary;
		/**
		 * 当前待加载的资源索引
		 */
		private var _index:int;
		
		/**
		 * 资源配置xml文件地址
		 */
		public function ResourceLoader()
		{
			_queue = new Array();
			_assets = new Dictionary();
		}
		
		public function addFile(uri:String):void
		{
			
		}
		
		public function addAssetsFile(uri:String):void
		{
			_files.push(uri);
			
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(uri);
			
			loader.addEventListener(Event.COMPLETE, function(event:Event):void{
				var data:XML = new XML(event.target.data);
				
				for each(var item:XML in data.item)
				{
					_queue.push(item);
				}

			});
			
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
			loadFile();
		}
		
		private function loadFile():void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function(event:Event):void{
				if(++_index < _queue.length)
				{
					loadFile();
				}
			});
			
			var request:URLRequest = new URLRequest(_queue[_index]);
			loader.load(request);
		}
		
	}
}