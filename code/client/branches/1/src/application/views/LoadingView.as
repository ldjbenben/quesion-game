package application.views
{
	import benben.Benben;
	import benben.display.widgets.loading.Loading;
	import benben.events.AssetsProgressEvent;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class LoadingView extends BaseView
	{
		private var _loading:Loading;
		
		public function LoadingView()
		{
			super();
		}
		
		override public function init():void
		{
			_loading = new Loading;
			_loading.bgFile = "assets/imgs/bg_6001.jpg";
			_loading.run();
			addChild(_loading);
			
			// 注册事件
			Benben.app.assetsLoader.addEventListener(AssetsProgressEvent.PROGRESS, onLoadAssetsProgress);
			Benben.app.assetsLoader.addEventListener(Event.COMPLETE, onLoadAssetsComplete);
			Benben.app.assetsLoader.load();
		}
		
		private function onLoadAssetsProgress(evt:AssetsProgressEvent):void
		{
			_loading.updateProgress(evt.bytesLoaded, evt.bytesTotal, evt.numLoaded, evt.numTotal, evt.title);
		}
		
		/**
		 * @todo 这里存在一个问题，还没等进度条最后满格就已经进入下一个视图，因为进度条
		 * 视图渲染需要时间，而代码是异步执行的，所以会跳过动画，暂时可以加个延迟来解决此问题。
		 */
		private function onLoadAssetsComplete(evt:Event):void
		{
			_loading.complete();
			Benben.app.viewManager.jump("main");
		}
	}
}