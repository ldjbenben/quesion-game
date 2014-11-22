package bui.skins.ben
{
	import bui.skins.ProgrammaticSkin;
	
	import flash.sampler.stopSampling;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	
	public class ScrollArrowSkin extends ProgrammaticSkin
	{
		protected var _color:uint = 0x999999;
		
		public function ScrollArrowSkin(color:uint = 0x999999)
		{
			_color = color;
			_measureWidth = 20;
			_measureHeight = 20;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function commonState():void
		{

		}

		private function downState():void
		{
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			graphics.beginFill(_color);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
			
		}
		
		private function onMouseDown(evt:MouseEvent):void
		{

		}

		private function onMouseUp(evt:MouseEvent):void
		{

		}
	}
}