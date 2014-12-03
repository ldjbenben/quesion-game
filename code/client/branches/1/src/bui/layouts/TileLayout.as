package bui.layouts
{
	import bui.layouts.supportClasses.LayoutBase;
	
	import flash.display.DisplayObject;
	
	public class TileLayout extends LayoutBase
	{
		private var _requestedRowCount:int = 5;
		private var _requestedColumnCount:int = 5;
		/**
		 * 一页几行
		 */
		private var _pageSize:int = -1;
		/**
		 * 指定是逐行还是逐列排列元素。
		 * 可以是 TileOrientation.ROWS 和 TileOrientation.COLUMNS。
		 */
		private var _orientation:String;
		
		public function TileLayout()
		{
			super();
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
			var xPos:Number = 0;
			var yPos:Number = 0;
			var rowNo:int = index / columnCount;
			
			xPos = (index % columnCount) * (columnWidth + horizontalGap);
			yPos = rowNo * (rowHeight + verticalGap);
			
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

		/**
		 * 一页几行
		 */
		public function get pageSize():int
		{
			return _pageSize;
		}

		/**
		 * @private
		 */
		public function set pageSize(value:int):void
		{
			_pageSize = value;
		}

		/**
		 * 要显示的行数
		 */
		public function get requestedRowCount():int
		{
			return _requestedRowCount;
		}

		/**
		 * @private
		 */
		public function set requestedRowCount(value:int):void
		{
			_requestedRowCount = value;
		}

		/**
		 * 要显示的列数
		 */
		public function get requestedColumnCount():int
		{
			return _requestedColumnCount;
		}

		/**
		 * @private
		 */
		public function set requestedColumnCount(value:int):void
		{
			_requestedColumnCount = value;
		}


	}
}