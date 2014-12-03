package bui.skins
{
	import bui.base.UIComponent;
	
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class ProgrammaticSkin extends UIComponent
	{
		public function ProgrammaticSkin()
		{
			addEventListener(Event.ADDED, onAdded);
		}
		
		private function onAdded(evt:Event):void
		{
			if(evt.eventPhase == 2)
			{
				reDraw();
				evt.stopPropagation();
			}
		}
		
		public function reDraw():void
		{
			updateDisplayList(_unscaleWidth, _unscaleHeight);
		}
	}
}