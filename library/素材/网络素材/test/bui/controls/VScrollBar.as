package bui.controls
{
	import bui.controls.supportClasses.ScrollBar;
	import bui.events.ScrollEvent;
	import bui.skins.ben.ScrollArrowSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class VScrollBar extends ScrollBar
	{
		protected var _downY:Number;
		private var _preY:Number;
		
		public function VScrollBar()
		{

		}
		
		override protected function onLineMouseDown(evt:MouseEvent):void
		{
			_downY = evt.localY + _upArrow.height;
		}
		
		override protected function onLineMouseUp(evt:MouseEvent):void
		{
			_downY = 0;
		}
		
		override protected function onTrackMouseMove(evt:MouseEvent):void
		{
			if(evt.buttonDown)
			{
				var i:Number = evt.stageY - _downY;
				
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
					_line.y = evt.stageY - _downY;
				}
				
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
					
					scrollEvt.position = _line.y * pageNum;
					trace("position:"+scrollEvt.position);
					dispatchEvent(scrollEvt);
				}
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
		}
		
		
	}
}