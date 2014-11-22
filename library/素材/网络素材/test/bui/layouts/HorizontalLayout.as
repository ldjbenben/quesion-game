package bui.layouts
{
	import bui.layouts.supportClasses.LayoutBase;
	
	import flash.display.DisplayObject;
	
	public class HorizontalLayout extends LayoutBase
	{
		protected var _horizontalSpacing:Number = 10;
		
		override public function elementAdded(index:int):void
		{
			var element:DisplayObject = _target.getElement(index);
			var xPos:Number = 0;
			
			for(var i:int = 0; i < index; i++)
			{
				xPos += _target.getElement(i).width + _horizontalSpacing;
			}
			
			for(i = index+1; i < _target.elements.length; i++)
			{
				_target.getElement(i).x += element.width + _horizontalSpacing;
			}
			
			element.x = xPos;
		}
		
		override public function elementRemoved(index:int):void
		{
			
		}

		public function get horizontalSpacing():Number
		{
			return _horizontalSpacing;
		}

		public function set horizontalSpacing(value:Number):void
		{
			_horizontalSpacing = value;
		}
		
	}
}