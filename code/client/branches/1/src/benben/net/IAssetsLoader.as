package benben.net
{
	public interface IAssetsLoader
	{
		public var numTotal:int;
		public var numLoaded:int;
		
		public function updateProgress (bytesTotal: Number, bytesLoaded: Number, name: String):void;
		public function oneComplete():void;
		public function complete():void;
	}
}