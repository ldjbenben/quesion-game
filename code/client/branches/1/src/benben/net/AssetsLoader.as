package benben.net
{
	import benben.base.Component;
	import benben.display.widgets.loading.Loading;
	import benben.events.AssetsProgressEvent;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	public class AssetsLoader extends Component
	{
		private var _assetsFile:String;
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
//		private var _files:Array;
		
		/**
		 * 资源配置xml文件地址
		 */
		public function AssetsLoader()
		{
			_queue = new Array();
			_assets = new Dictionary();
//			_files = new Array();
		}
		
		public function addFile(uri:String):void
		{
			
		}
		
		public function load():void
		{
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(_assetsFile);
			
			loader.addEventListener(Event.COMPLETE, function(event:Event):void{
				
				var data:XML = new XML(event.target.data);
				
				for each(var item:XML in data.item)
				{
					_queue.push({"id":String(item.@id), "title":String(item.@title), "uri":String(item.@uri), "delay":Boolean(String(item.@delay))});
				}
				
				loadFile();
				
			});
			
			loader.load(request);
		}
		
		/*
		public function addAssetsFile(uri:String):void
		{
			_files.push(uri);
		}
		*/
		
		/*
		public function load():void
		{
			var index:int;
			
			for(var i:int=0; i<_files.length; i++)
			{
				var loader:URLLoader = new URLLoader();
				var request:URLRequest = new URLRequest(_files[i]);
				
				loader.addEventListener(Event.COMPLETE, function(event:Event):void{
					
					var data:XML = new XML(event.target.data);
					
					for each(var item:XML in data.item)
					{
						_queue.push({"id":item.@id, "title":item.@title, "uri":item.@uri});
					}
					
					if(++index == _files.length) // 全部资源列表就位
					{
						if(_queue.length > 0)
						{
							loadFile();
						}
					}
				});
				
				loader.load(request);
			}
		}
		*/
		
		/**
		 * 加载文件的具体工作代码
		 * 之所以必须一个加载完才能继续加载下一个资源文件，是因为在文件加载完成后无法获知
		 * 当前加载完的文件对应 哪个资源ID.
		 */
		private function loadFile():void
		{
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(_queue[_index].uri);
			
			loader.addEventListener(ProgressEvent.PROGRESS, onLoadFileProgress);
			loader.addEventListener(Event.COMPLETE, onLoadFileComplete);
			
			loader.load(request);
		}
		
		private function onLoadFileProgress(evt:ProgressEvent):void
		{
			var newEvent:AssetsProgressEvent = new AssetsProgressEvent(AssetsProgressEvent.PROGRESS);
			
			newEvent.bytesLoaded = evt.bytesLoaded;
			newEvent.bytesTotal = evt.bytesTotal;
			newEvent.numLoaded = _index;
			newEvent.numTotal = _queue.length;
			newEvent.title = _queue[_index].title;
			
			dispatchEvent(newEvent);
		}
		
		private function onLoadFileComplete(evt:Event):void
		{
			var key:String = _queue[_index++].id;
			_assets[key] = evt.target.data;
			
			if(_index < _queue.length)
			{
				var newEvent:AssetsProgressEvent = new AssetsProgressEvent(AssetsProgressEvent.ONE_START);
				
				newEvent.bytesLoaded = 0;
				newEvent.bytesTotal = 0;
				newEvent.numLoaded = _index;
				newEvent.numTotal = _queue.length;
				newEvent.title = _queue[_index].title;
				dispatchEvent(newEvent);
				
				loadFile();
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		/**
		 * 资源配置清单xml文件
		 */
		public function set assetsFile(value:String):void
		{
			_assetsFile = value;
		}

	}
}