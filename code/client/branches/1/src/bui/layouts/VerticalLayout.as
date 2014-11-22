package bui.layouts
{
	import bui.layouts.supportClasses.LayoutBase;
	
	import flash.display.DisplayObject;
	
	public class VerticalLayout extends LayoutBase
	{
		override public function elementAdded(element:DisplayObject, index:int):void
		{
			var yPos:Number = 0;
			
			for(var i:int = 0; i < index; i++)
			{
				yPos += _target.getElement(i).height + verticalGap;
			}
			
			for(i = index+1; i < _target.elements.length; i++)
			{
				_target.getElement(i).y += element.height + verticalGap;
			}
			
			element.y = yPos;
		}
		
		override public function elementRemoved(element:DisplayObject, index:int):void
		{
			for(var i:int = index; i < _target.elements.length; i++)
			{
				_target.getElement(i).y -= element.height + verticalGap;
			}
		}

		public function get verticalSpacing():Number
		{
			return verticalGap;
		}

		public function set verticalSpacing(value:Number):void
		{
			verticalGap = value;
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