package application.views
{
	import benben.Benben;
	
	import flash.display.Sprite;
	
	import wzq.Room;
	
	public class RoomView extends BaseView
	{
		private var _roomId:int;
		private var _room:Sprite;
		
		override public function init():void
		{
			super.init();
			_room = Benben.app.assetsLoader.getSwf("room") as Sprite;
			addChild(_room);
		}
		
		override public function enter():void
		{
			
		}

		public function get room():Sprite
		{
			return _room;
		}

	}
}