package bui.controls
{
	import bui.base.UIComponent;
	
	public class List extends UIComponent
	{
		private var _dataProvider:Array;
		public var vScroll:Boolean;
		public var hScroll:Boolean;
		public var columnCount:Number;
		private var rowCount:Number;
		public var cellPadding:Number = 0;
		
		public function List()
		{
			super();
		}
		
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

		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
		}

	}
}