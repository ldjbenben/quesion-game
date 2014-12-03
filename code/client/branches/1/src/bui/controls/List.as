package bui.controls
{
	import bui.base.Area;
	import bui.base.UIComponent;
	import bui.events.ScrollEvent;
	import bui.layouts.TileLayout;
	import bui.layouts.supportClasses.LayoutBase;
	import flash.display.DisplayObject;
	
	public class List extends UIComponent
	{
		private var _autoAlign:Boolean;
		private var _dataProvider:Array;
		private var _group:Group;
		private var _layout:LayoutBase;
		private var _vScroll:VScrollBar;
		private var _hScroll:HScrollBar;
		private var _contentArea:Area;
		
		public function List()
		{
			_unscaleWidth = 200;
			_unscaleHeight = 300;
			_group = new Group();
			_layout = new TileLayout();
			_vScroll = new VScrollBar();
			_hScroll = new HScrollBar();
			
			_layout.target = _group;
			_group.layout = _layout;
			_vScroll.addEventListener(ScrollEvent.SCROLL, onVScrolling);
		}
		
		public function getItem(index:int):Object
		{
			return _group.getElement(index);
		}
		
		private function onVScrolling(evt:ScrollEvent):void
		{
			_group.y = -evt.position;
		}
		
		public function addItem(item:DisplayObject, index:int = -1):void
		{
			_group.addElement(item, index);
			_vScroll.contentHeight = _group.height;
		}
		
		public function removeItem(index:int):void
		{
			_group.removeElement(index);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			graphics.beginFill(0xffffff, 0);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
			
			addChild(_vScroll);
			addChild(_group);
			//scrollRect = new Rectangle(0, 0, _group.width + _vScroll.width, _unscaleHeight);
			_vScroll.scrollSize = _unscaleHeight;
			_vScroll.x = _group.width;
			_vScroll.contentHeight = _group.height;
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