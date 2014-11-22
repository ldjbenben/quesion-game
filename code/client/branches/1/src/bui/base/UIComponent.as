package bui.base
{
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * 所有显示组件的基类
	 */
	public class UIComponent extends Sprite
	{
		public function UIComponent()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(evt:Event):void
		{
			var item:Sprite = evt.target as Sprite;
			updateDisplayList(item.width, item.height);
		}
		
		protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
	}
}