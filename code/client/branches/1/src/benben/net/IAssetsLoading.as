package benben.net
{
	public interface IAssetsLoading
	{
		function updateProgress (bytesTotal: Number, bytesLoaded: Number, name: String):void;
		function oneComplete():void;
		function complete():void;
		function set numTotal(value:int):void;
		function set numLoaded(value:int):void;
	}
}