package bui.layouts
{
	import bui.layouts.supportClasses.LayoutBase;
	
	public class TileLayout extends LayoutBase
	{
		public var columnWidth:Number;
		public var rowHeight:Number;
		public var verticalGap:Number;
		public var horizontalGap:Number;
		/**
		 * 指定是逐行还是逐列排列元素。
		 * 可以是 TileOrientation.ROWS 和 TileOrientation.COLUMNS。
		 */
		private var _orientation:String;
		
		
		public function TileLayout()
		{
			
		}
		
		public function elementAdded(index:int):void
		{
		
		}
		
		public function elementRemoved(index:int):void
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