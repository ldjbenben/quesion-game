package benben.net.connectors
{
	public interface IConnector
	{
		function addParam(key:String, value:*, type:String):void;
		function request(apiname:String, callback:Function):void;
	}
}