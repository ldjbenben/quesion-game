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
			_measureWidth = 20;
			_measureHeight = 20;

			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		override protected function states():Dictionary
		{
			var dic:Dictionary = new Dictionary();
			dic["common"] = commonState;
			dic["down"] = downState;
			return dic;
		}

		private function commonState():void
		{
			if (_commonState == null)
			{
				_commonState = new Shape();
				_commonState.graphics.beginFill(0x006699);
				_commonState.graphics.drawRect(0, 0, _measureWidth, _measureHeight);
				_commonState.graphics.endFill();
			}
			addChild(_commonState);
		}

		private function downState():void
		{
			if (_downState == null)
			{
				_downState = new Shape();
				_downState.graphics.beginFill(0x00FF99);
				_downState.graphics.drawRect(0, 0, _measureWidth, _measureHeight);
				_downState.graphics.endFill();
			}
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			jumpState("common");
			//addChild(_commonState);
		}

		private function onMouseDown(evt:MouseEvent):void
		{
			downState();
			removeChild(_commonState);
			addChild(_downState);
		}

		private function onMouseUp(evt:MouseEvent):void
		{
			removeChild(_downState);
			addChild(_commonState);
		}
		
	}
}