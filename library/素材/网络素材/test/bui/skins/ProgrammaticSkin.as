package bui.skins
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class ProgrammaticSkin extends Sprite
	{
		protected var _states:Dictionary;
		protected var _measureWidth:Number;
		protected var _measureHeight:Number;
		
		public var _ddd:Number;
		
		public function ProgrammaticSkin()
		{
			_states = new Dictionary();
			addEventListener(Event.ADDED, onAdded);
			_states = states();
		}
		
		protected function states():Dictionary
		{
			return new Dictionary();
		}
		
		protected function jumpState(id:String):void
		{
				_states[id]();
		}
		
		private function onAdded(evt:Event):void
		{
			if(evt.eventPhase == 2)
			{
				var item:ProgrammaticSkin = evt.target as ProgrammaticSkin;
				//var w:Number = item.width ? item.width : _measureWidth;
				//var h:Number = item.height ? item.height : _measureHeight;
				
				updateDisplayList(_measureWidth, _measureHeight);
				evt.stopPropagation();
			}
		}
		
		protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
		
		
		public function set measureHeight(value:Number):void
		{
			_measureHeight = value;
		}
		
		public function set measureWidth(value:Number):void
		{
			_measureWidth = value;
		}
	}
}