package bui.layouts.supportClasses
{
	import bui.controls.supportClasses.GroupBase;
	
	import flash.display.DisplayObject;

	public class LayoutBase
	{
		protected var _target:GroupBase;
		protected var _verticalGap:Number = 0;
		protected var _horizontalGap:Number = 0;
		protected var _rowHeight:Number = 0;
		protected var _rowCount:int;
		protected var _columnWidth:Number = 0;
		protected var _columnCount:int = 0;
		
		
		public function elementAdded(element:DisplayObject, index:int):void
		{
		}
		
		public function elementRemoved(element:DisplayObject, index:int):void
		{
		}
		
		protected function calculatePosition():void
		{
		
		}
		
		public function set target(value:GroupBase):void
		{
			_target = value;
		}

		public function get columnWidth():Number
		{
			return _columnWidth;
		}

		public function set columnWidth(value:Number):void
		{
			_columnWidth = value;
		}

		public function get columnCount():int
		{
			return _columnCount;
		}

		public function set columnCount(value:int):void
		{
			_columnCount = value;
		}

		public function get rowCount():int
		{
			return _rowCount;
		}

		public function set rowCount(value:int):void
		{
			_rowCount = value;
		}

		public function get horizontalGap():Number
		{
			return _horizontalGap;
		}

		public function set horizontalGap(value:Number):void
		{
			_horizontalGap = value;
		}

		public function get verticalGap():Number
		{
			return _verticalGap;
		}

		public function set verticalGap(value:Number):void
		{
			_verticalGap = value;
		}

		public function get rowHeight():Number
		{
			return _rowHeight;
		}

		public function set rowHeight(value:Number):void
		{
			_rowHeight = value;
		}


	}
}