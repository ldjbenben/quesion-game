package benben.net
{
	import benben.base.Component;
	import benben.display.Loading;
	
	import events.AssetsProgressEvent;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	public class AssetsLoader extends Component
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
		private var _loading:Loading;
		
		/**
		 * 资源配置xml文件地址
		 */
		public function AssetsLoader()
		{
			_queue = new Array();
			_assets = new Dictionary();
			_files = new Array();
		}
		
		public function addFile(uri:String):void
		{
			
		}
		
		public function addAssetsFile(uri:String):void
		{
			_files.push(uri);
		}
		
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
						_queue.push({"id":item.@id, "name":item.@name, "uri":item.@uri});
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
		
		private function loadFile():void
		{
			var loader:URLLoader = new URLLoader();
			
			// 某素材加载中事件
			loader.addEventListener(ProgressEvent.PROGRESS, function(event:ProgressEvent):void{
				/*var progressEvent:AssetsProgressEvent = new AssetsProgressEvent(ProgressEvent.PROGRESS);
				progressEvent.numLoaded = _index;
				progressEvent.numTotal = _queue.length;
				progressEvent.bytesLoaded = event.bytesLoaded;
				progressEvent.bytesTotal = event.bytesTotal;
				dispatchEvent(progressEvent);*/
				loading.updateProgress(event.bytesLoaded, event.bytesTotal, _queue[_index].name);
			});
			
			// 某素材加载完成事件
			loader.addEventListener(Event.COMPLETE, 
				function(event:Event):void
				{
					var key:String = _queue[_index++].id;
					_assets[key] = loader.data;
					
					if(_index < _queue.length)
					{
						var progressEvent:AssetsProgressEvent = new AssetsProgressEvent(AssetsProgressEvent.ONE_COMPLETE);
						progressEvent.numLoaded = _index;
						progressEvent.numTotal = _queue.length;
						dispatchEvent(progressEvent);
						loadFile();
					}
					else
					{
						dispatchEvent(new Event(Event.COMPLETE));
					}
				}
			);
			
			var request:URLRequest = new URLRequest(_queue[_index].uri);
			loader.load(request);
		}

		/**
		 * 资源加载进度条
		 */
		public function get loading():Loading
		{
			return _loading;
		}

		/**
		 * @private
		 */
		public function set loading(value:Loading):void
		{
			_loading = value;
		}

	}
}