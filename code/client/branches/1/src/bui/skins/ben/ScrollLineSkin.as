package bui.skins.ben
{
	import bui.skins.ProgrammaticSkin;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	import flash.utils.Dictionary;

	public class ScrollLineSkin extends ProgrammaticSkin
	{
		private var _commonState:Shape;
		private var _downState:Shape;

		public function ScrollLineSkin()
		{
			_unscaleWidth = 20;
			_unscaleHeight = 20;

			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			registerStatement("common", commonStatement);
			registerStatement("down", downStatement);
		}
		
		public function commonStatement(enter:Boolean = true):void
		{
			if(_commonState) removeChild(_commonState);
			_commonState = new Shape();
			_commonState.graphics.beginFill(0x006699);
			_commonState.graphics.drawRect(0, 0, _unscaleWidth, _unscaleHeight);
			_commonState.graphics.endFill();
			addChild(_commonState);
		}

		public function downStatement(enter:Boolean = true):void
		{
			_downState = new Shape();
			_downState.graphics.beginFill(0x00FF99);
			_downState.graphics.drawRect(0, 0, _unscaleWidth, _unscaleHeight);
			_downState.graphics.endFill();
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			statement = "common";
		}

		private function onMouseDown(evt:MouseEvent):void
		{
			statement = "down";
		}

		private function onMouseUp(evt:MouseEvent):void
		{
			statement = "common";
		}
		
	}
}