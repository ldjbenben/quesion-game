package bui.skins.ben
{
	import bui.skins.ProgrammaticSkin;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.sampler.stopSampling;
	import flash.utils.Dictionary;
	
	public class ScrollArrowSkin extends ProgrammaticSkin
	{
		protected var _color:uint = 0x999999;
		private var _commonState:Shape;
		private var _downState:Shape;
		
		public function ScrollArrowSkin(color:uint = 0x999999)
		{
			_color = color;
			_unscaleWidth = 20;
			_unscaleHeight = 20;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			registerStatement("common", commonStatement);
			registerStatement("down", downStatement);
		}
		
		private function commonStatement(enter:Boolean = true):void
		{
			_commonState = new Shape();
			_commonState.graphics.beginFill(_color);
			_commonState.graphics.drawRect(0, 0, _unscaleWidth, _unscaleHeight);
			_commonState.graphics.endFill();
			addChild(_commonState);
		}

		private function downStatement(enter:Boolean = true):void
		{
			_downState = new Shape();
			_downState.graphics.beginFill(0x00FF99);
			_downState.graphics.drawRect(0, 0, _unscaleWidth, _unscaleHeight);
			_downState.graphics.endFill();
			addChild(_downState);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			statement = "common";
		}
		
		private function onMouseDown(evt:MouseEvent):void
		{

		}

		private function onMouseUp(evt:MouseEvent):void
		{

		}
	}
}