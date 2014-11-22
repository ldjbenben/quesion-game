package bui.layouts
{
	import bui.layouts.supportClasses.LayoutBase;
	
	import flash.display.DisplayObject;
	
	public class VerticalLayout extends LayoutBase
	{
		protected var _verticalSpacing:Number = 10;
		
		override public function elementAdded(index:int):void
		{
			var element:DisplayObject = _target.getElement(index);
			var yPos:Number = 0;
			
			for(var i:int = 0; i < index; i++)
			{
				yPos += _target.getElement(i).height + _verticalSpacing;
			}
			
			for(i = index+1; i < _target.elements.length; i++)
			{
				_target.getElement(i).y += element.height + _verticalSpacing;
			}
			
			element.y = yPos;
		}
		
		override public function elementRemoved(index:int):void
		{
			
		}

		public function get verticalSpacing():Number
		{
			return _verticalSpacing;
		}

		public function set verticalSpacing(value:Number):void
		{
			_verticalSpacing = value;
		}
		
		
		
		/*
		override public function layout():void
		{
			var yPos:Number = 0;
			
			for(var i:int; i<items.length; i++)
			{
				if(i > 0)
				{
					yPos = items[i-1].height  + _cellSpacing;
				}
				
				items[i].y = yPos;
				target.addChild(items[i]);
			}
		}
		*/
	}
}