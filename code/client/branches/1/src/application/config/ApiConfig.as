package application.config
{
	import flash.utils.Dictionary;

	public class ApiConfig
	{
		private static var _data:Dictionary;
		private static var _initial:Boolean = false;
		
		public static function get(apiname:String):Object
		{
			if(!_initial)
			{
				initData();
				_initial = true;
			}
			
			return _data[apiname];
		}
		
		private static function initData():void
		{
			_data = new Dictionary();
			
			_data["userLogin"] = {"id":1};
		}
	}
}