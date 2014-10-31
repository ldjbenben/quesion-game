package benben.net
{
	public interface IAssetsLoading
	{
		function updateProgress (bytesLoaded:Number, bytesTotal:Number, numLoaded:int, numTotal:int, title:String):void;
		function complete():void;
	}
}