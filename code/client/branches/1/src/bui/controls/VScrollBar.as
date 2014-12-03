package bui.controls
{
	import bui.controls.supportClasses.ScrollBar;
	import bui.events.ScrollEvent;
	
	import flash.events.MouseEvent;

	public class VScrollBar extends ScrollBar
	{
		protected var _downY:Number;
		protected var _downLocalY:Number;
		private var _preY:Number;
		
		public function VScrollBar()
		{

		}
		
		private function onChange():void
		{
			var delta:Number = _line.y - _preY;
			if(delta != 0)
			{
				// 抛出ScrollEvent事件
				var scrollEvt:ScrollEvent = new ScrollEvent();
				
				scrollEvt.delta = delta;
				
				if(scrollEvt.delta > 0)
				{
					scrollEvt.direction = 'up';
				}
				else if(scrollEvt.delta < 0)
				{
					scrollEvt.direction = 'down';
				}
				
				scrollEvt.position = _line.y * (_track.height/_line.height);
				dispatchEvent(scrollEvt);
			}
			_preY = _line.y;		
		}
		
		override protected function onLineMouseDown(evt:MouseEvent):void
		{
			_downLocalY = evt.localY;
		}
		
		override protected function onLineMouseUp(evt:MouseEvent):void
		{
		}
		
		override protected function onUpArrowClick(evt:MouseEvent):void
		{
			var i:Number = _line.y - pageScrollSize;
			if(i < 0)
			{
				_line.y = 0;
			}
			else
			{
				_line.y = i;
			}
			
			onChange();
		}
		
		override protected function onDownArrowClick(evt:MouseEvent):void
		{
			var i:Number = _line.y + pageScrollSize;
			if(i > _track.height)
			{
				_line.y = _track.height;
			}
			else
			{
				_line.y = i;
			}
			
			onChange();
		}
		
		override protected function onTrackMouseDown(evt:MouseEvent):void
		{
			_trackStageY = evt.stageY - evt.currentTarget.mouseY; 
		}
		
		override protected function onTrackMouseMove(evt:MouseEvent):void
		{
			if(evt.buttonDown)
			{
				var i:Number = evt.stageY - _trackStageY - _downLocalY;
				if(i < 0)
				{
					_line.y = 0;
				}
				else if(i > _scrollSize - _line.height)
				{
					_line.y = _scrollSize - _line.height;
				}
				else
				{
					_line.y = i;
				}
				
				onChange();
			}
		}
		
		override protected function onTrackMouseClick(evt:MouseEvent):void
		{
			if(evt.localY > _line.y)
			{
				_line.y += pageScrollSize;
			}
			else
			{
				_line.y -= pageScrollSize;
			}
			
			onChange();
		}
		
		override public function set contentHeight(value:Number):void
		{
			_contentHeight = value;
			adjustLineSize();
		}
		
		override protected function adjustLineSize():void
		{
			if(scrollSize >= _contentHeight)
			{
				_line.visible = false;
			}
			else
			{
				_line.unscaleHeight = scrollSize * scrollSize / _contentHeight;
				_line.visible = true;
			}
			
			_line.reDraw();
		}
	}
}