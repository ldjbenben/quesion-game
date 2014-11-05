package benben.net.connectors
{
	public interface IConnector
	{
		function set(key:String, value:*, type:String):void;
		function send(apiname:String, callback:Function):void;
	}
}