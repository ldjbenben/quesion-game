package bui.layouts
{
	import bui.layouts.supportClasses.LayoutBase;
	
	import flash.display.DisplayObject;
	
	public class TileLayout extends LayoutBase
	{
		/**
		 * 指定是逐行还是逐列排列元素。
		 * 可以是 TileOrientation.ROWS 和 TileOrientation.COLUMNS。
		 */
		private var _orientation:String;
		
		public function TileLayout()
		{
			
		}
		
		override public function elementAdded(element:DisplayObject, index:int):void
		{
			layoutByRow(element, index);
		}
		
		override public function elementRemoved(element:DisplayObject, index:int):void
		{
			removeByRow(element, index);
		}
		
		/**
		 * 优先按行排列
		 * 需要用到列数
		 */
		protected function layoutByRow(element:DisplayObject, index:int):void
		{
			var element:DisplayObject = _target.getElement(index);
			var xPos:Number = 0;
			var yPos:Number = 0;
			var rowNo:int = index / columnCount;
			
			xPos = (index % columnCount) * columnWidth;
			yPos = rowNo * rowHeight;
			
			element.x = xPos;
			element.y = yPos;
		}
		
		protected function removeByRow(element:DisplayObject, index:int):void
		{
			for(var i:int = index; i < _target.elements.length; i++)
			{
				layoutByRow(_target.elements[i], i);
			}
		}
		
		protected function layoutByCol():void
		{
		}

		public function get orientation():String
		{
			return _orientation;
		}

		public function set orientation(value:String):void
		{
			_orientation = value;
		}

	}
}