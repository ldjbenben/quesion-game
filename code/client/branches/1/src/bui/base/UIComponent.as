package bui.base
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * 所有显示组件的基类
	 */
	public class UIComponent extends Sprite
	{
		protected var _statements:Dictionary;
		private var _statement:String;
		protected var _unscaleWidth:Number;
		protected var _unscaleHeight:Number;
		
		public function UIComponent()
		{
			_statements = new Dictionary();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(evt:Event):void
		{
			updateDisplayList(_unscaleWidth, _unscaleHeight);
		}
		
		protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
		
		protected function registerStatement(id:String, func:Function):void
		{
			_statements[id] = func;
		}
		
		/**
		 * statement of table.
		 */
		public function get statement():String
		{
			return _statement;
		}

		/**
		 * @private
		 */
		public function set statement(value:String):void
		{
			if(_statements[value] != null)
			{
				if(_statement)
				{
					_statements[_statement](false);
				}
				_statements[value](true);
				_statement = value;
			}
		}
		
		public function set unscaleHeight(value:Number):void
		{
			_unscaleHeight = value;
		}
		
		public function set unscaleWidth(value:Number):void
		{
			_unscaleWidth = value;
		}

	}
}