package bui.layouts.supportClasses
{
	import bui.controls.supportClasses.GroupBase;
	
	import flash.display.Sprite;

	public class LayoutBase
	{
		protected var _target:GroupBase;
		protected var _cellSpacing:Number = 0;
		protected var _itemCount:Number;
		protected var _rowHeight:Number;
		protected var _columnWidth:Number;
		
		public function layout():void
		{
		
		}
		
		public function elementAdded(index:int):void
		{
		}
		
		public function elementRemoved(index:int):void
		{
		}
		
		protected function calculatePosition():void
		{
		
		}
		
		public function get cellSpacing():Number
		{
			return _cellSpacing;
		}
		
		public function set cellSpacing(value:Number):void
		{
			_cellSpacing = value;
		}

		public function set target(value:GroupBase):void
		{
			_target = value;
		}


	}
}