package bui.controls.supportClasses
{
	import flash.events.MouseEvent;
	
	import bui.base.UIComponent;
	import bui.skins.ProgrammaticSkin;
	import bui.skins.ben.ScrollArrowSkin;
	import bui.skins.ben.ScrollLineSkin;
	import bui.skins.ben.ScrollTrackSkin;

	public class ScrollBar extends UIComponent
	{
		/**
		 * 指定 ScrollBar 是用于水平滚动还是垂直滚动。
		 * v表示垂直滚动条，h表示水平滚动条
		 */
		protected var _direction:String = "v";
		/**
		 * 控件尺寸大小（以像素为单位）。
		 */
		protected var _scrollSize:Number = 200;
		/**
		 * 控件厚度
		 */
		protected var _scrollThickness:Number = 15;
		/**
		 * 按下箭头按钮时的滚动量（以像素为单位）。
		 */
		public var lineScrollSize:Number;
		/**
		 * 表示最大滚动位置的数值。
		 */
		public var maxScrollPosition:Number;
		/**
		 * 表示最小滚动位置的数值。
		 */
		public var minScrollPosition:Number;
		/**
		 * 按下滚动条轨道时滚动滑块的移动量（以像素为单位）。
		 */
		public var pageScrollSize:Number = 10;
		/**
		 * 页数。
		 */
		public var pageNum:Number = 1;
		/**
		 * 表示当前滚动位置的数值。
		 */
		private var _scrollPosition:Number;
		/**
		 * ScrollBar 中向前箭头的外观
		 */
		protected var _upArrow:ProgrammaticSkin;
		/**
		 * ScrollBar 中向后箭头的外观
		 */
		protected var _downArrow:ProgrammaticSkin;
		/**
		 * ScrollBar 中轨道的外观
		 */
		protected var _track:ProgrammaticSkin;
		/**
		 * ScrollBar 中拉条的外观
		 */
		protected var _line:ProgrammaticSkin;
		/**
		 * 内容高度.垂直滚动条根据此项来得知内容实际高度
		 */
		protected var _contentHeight:Number = 0;
		/**
		 * 内容宽度.垂直滚动条根据此项来得知内容实际宽度
		 */
		protected var _contentWdith:Number = 0;
		protected var _trackStageY:Number = 0;
		protected var _trackStageX:Number = 0;
		
		
		public function ScrollBar()
		{
			_upArrow = new ScrollArrowSkin();
			_downArrow = new ScrollArrowSkin();
			_track = new ScrollTrackSkin();
			_line = new ScrollLineSkin();
			
			_line.addEventListener(MouseEvent.MOUSE_DOWN, onLineMouseDown);
			_line.addEventListener(MouseEvent.MOUSE_UP, onLineMouseUp);
			_line.addEventListener(MouseEvent.CLICK, onLineMouseClick);
			_track.addEventListener(MouseEvent.MOUSE_DOWN, onTrackMouseDown);
			_track.addEventListener(MouseEvent.MOUSE_MOVE, onTrackMouseMove);
			_track.addEventListener(MouseEvent.CLICK, onTrackMouseClick);
			_upArrow.addEventListener(MouseEvent.CLICK, onUpArrowClick);
			_downArrow.addEventListener(MouseEvent.CLICK, onDownArrowClick);
		}
		
		public function get contentWdith():Number
		{
			return _contentWdith;
		}

		public function set contentWdith(value:Number):void
		{
			_contentWdith = value;
		}

		public function get contentHeight():Number
		{
			return _contentHeight;
		}

		public function set contentHeight(value:Number):void
		{
			_contentHeight = value;
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(_direction == "v")
			{
				vScroll(unscaledWidth, unscaledHeight);
			}
			else
			{
				hScroll(unscaledWidth, unscaledHeight);
			}
			
			adjustLineSize();
		}
		
		private function hScroll(unscaledWidth:Number, unscaledHeight:Number):void
		{
			_downArrow.x = _scrollSize;
			
			addChild(_track);
			_upArrow.rotation = -90;
			_downArrow.rotation = -90;
			_track.rotation = -90;
			addChild(_upArrow);
			addChild(_downArrow);
		}
		
		private function vScroll(unscaledWidth:Number, unscaledHeight:Number):void
		{
			_upArrow.unscaleWidth = scrollThickness;
			_upArrow.unscaleHeight = scrollThickness;
			_downArrow.unscaleWidth = scrollThickness;
			_downArrow.unscaleHeight = scrollThickness;
			addChild(_upArrow);
			
			_line.unscaleWidth = scrollThickness;
			_track.unscaleHeight = scrollSize;
			_track.unscaleWidth = scrollThickness;
			_track.addChild(_line);
			addChild(_track);
			
			_track.y = scrollThickness
			_downArrow.y = _track.y + _scrollSize;
			
			addChild(_downArrow);
		}
		
		protected function adjustLineSize():void
		{
		
		}
		
		protected function onLineMouseDown(evt:MouseEvent):void
		{
		}
		
		protected function onLineMouseUp(evt:MouseEvent):void
		{
		}
		
		protected function onTrackMouseDown(evt:MouseEvent):void
		{
			
		}
		
		protected function onTrackMouseMove(evt:MouseEvent):void
		{
		}
		
		protected function onTrackMouseClick(evt:MouseEvent):void
		{
		}
		
		protected function onLineMouseClick(evt:MouseEvent):void
		{
			evt.stopPropagation();
		}
		
		protected function onUpArrowClick(evt:MouseEvent):void
		{
		}
		
		protected function onDownArrowClick(evt:MouseEvent):void
		{
		}
		
		/**
		 * 表示当前滚动位置的数值。
		 */
		public function get scrollPosition():Number
		{
			return _scrollPosition;
		}

		/**
		 * 轨道的大小（以像素为单位）
		 */
		public function get scrollSize():Number
		{
			return _scrollSize;
		}

		/**
		 * @private
		 */
		public function set scrollSize(value:Number):void
		{
			_scrollSize = value;
		}

		/**
		 * 轨道的宽度（以像素为单位）
		 */
		public function get scrollThickness():Number
		{
			return _scrollThickness;
		}

		/**
		 * @private
		 */
		public function set scrollThickness(value:Number):void
		{
			_scrollThickness = value;
		}

	}
}