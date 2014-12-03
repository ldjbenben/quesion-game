package application.config
{
	import flash.utils.Dictionary;

	public class ApiConfig
	{
		private static var _serverApi:Dictionary;
		private static var _clientApi:Dictionary;
		private static var _initial:Boolean = false;
		
		public static function getServerApi(apiname:String):Object
		{
			if(!_initial)
			{
				initData();
				_initial = true;
			}
			
			return _serverApi[apiname];
		}
		
		public static function getClientApi(apiname:String):Object
		{
			if(!_initial)
			{
				initData();
				_initial = true;
			}
			return _clientApi[apiname];
		}
		
		private static function initData():void
		{
			_serverApi = new Dictionary();
			_clientApi = new Dictionary();
			
			_serverApi["userLogin"] = {"id":10000};
			_serverApi["getTables"] = {"id":10100};
			_serverApi["sitdown"] = {"id":10101};
			
			_clientApi["updateTables"] = {"id":100};
		}
	}
}