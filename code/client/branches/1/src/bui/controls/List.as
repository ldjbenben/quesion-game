package bui.controls
{
	import bui.base.UIComponent;
	import bui.controls.supportClasses.GroupBase;
	import bui.layouts.TileLayout;
	import bui.layouts.supportClasses.LayoutBase;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class List extends UIComponent
	{
		protected var _autoAlign:Boolean;
		private var _dataProvider:Array;
		protected var _group:Group;
		protected var _layout:LayoutBase;
		public var vScroll:VScrollBar;
		public var hScroll:HScrollBar;
		
		public function List()
		{
			_group = new Group();
			_layout = new TileLayout();
			_layout.target = _group;
			_group.layout = _layout;
			_layout = new TileLayout();
		}
		
		public function addItem(item:DisplayObject, index:int = -1):void
		{
			_group.addElement(item, index);
		}
		
		public function removeItem(index:int):void
		{
			_group.removeElement(index);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			addChild(_group);
		}
		/*
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			if(columnCount > 0)
			{
				var row:int;
				for(var i:int; i<_dataProvider.length; i++)
				{
					row = i/columnCount;
					addChild(_dataProvider[i]);
					_dataProvider[i].x = _dataProvider[i-1].x + _dataProvider[i-1].width + cellPadding;
					_dataProvider[i].y = row * _dataProvider[i].height + cellPadding;
				}
			}
			else
			{
				var col:int;
				for(var j:int; j<_dataProvider.length; j++)
				{
					col = j/rowCount;
					_dataProvider[j].x = j%rowCount * _dataProvider[j].width;
					_dataProvider[j].y = col * _dataProvider[j].height;
					addChild(_dataProvider[j]);
				}
			}
		}
*/
		
		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
		}

		public function get layout():LayoutBase
		{
			return _layout;
		}

		public function set layout(value:LayoutBase):void
		{
			_layout = value;
		}

	}
}