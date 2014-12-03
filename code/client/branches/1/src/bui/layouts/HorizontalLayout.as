package bui.layouts
{
	import bui.layouts.supportClasses.LayoutBase;
	
	import flash.display.DisplayObject;
	
	public class HorizontalLayout extends LayoutBase
	{
		protected var _horizontalSpacing:Number = 10;
		private var _maxHeight:Number = 0;
		
		override public function elementAdded(element:DisplayObject, index:int):void
		{
			var xPos:Number = 0;
			var yPos:Number = 0;
			var item:DisplayObject;
			var justifyHeight:Boolean = false;
			
			if(element.height > _maxHeight)
			{
				_maxHeight = element.height;
				justifyHeight = true;
			}
			
			for(var i:int = 0; i < index; i++)
			{
				item = _target.getElement(i);
				xPos += item.width + _horizontalSpacing;
				
				if(justifyHeight)
				{
					item.y = (_maxHeight - item.height) / 2;
				}
			}
			
			for(i = index+1; i < _target.elements.length; i++)
			{
				_target.getElement(i).x += element.width + _horizontalSpacing;
				
				if(justifyHeight)
				{
					item.y = (_maxHeight - item.height) / 2;
				}
			}
			
			element.x = xPos;
			element.y = (_maxHeight - element.height) / 2;
		}
		
		override public function elementRemoved(element:DisplayObject, index:int):void
		{
			for(var i:int = index; i < _target.elements.length; i++)
			{
				_target.getElement(i).x -= element.width + _horizontalSpacing;
			}
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