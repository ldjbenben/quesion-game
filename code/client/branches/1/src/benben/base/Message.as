package benben.base
{
	import benben.Benben;

	public class Message extends Component
	{
		private var _assetId:String;
		private var _data:XML;
		
		override public function init():void
		{
			_data = Benben.app.assetsLoader.getXml(_assetId);
		}
		
		public function getMsg(msgId:int):String
		{
			var item:XMLList = _data.item.@id=msgId;
			if(item == null)
			{
				return 'unknown error!';
			}
			return item[0].@value;
		}

		/**
		 * 消息配置文件ID, 取自Assets配置文件.
		 */
		public function set assetId(value:String):void
		{
			_assetId = value;
		}

	}
}