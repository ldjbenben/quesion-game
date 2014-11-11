package application.components
{
	import benben.Benben;
	import benben.net.connectors.SocketConnector;
	
	import flash.utils.ByteArray;

	public class MySocketConnector extends SocketConnector
	{
		override protected function beforeCallback(bytes:ByteArray):Boolean
		{
			var ret:int = bytes.readInt();
			
			if(ret != 0)
			{
				 trace(Benben.app.message.getMsg(ret));
			}
			
			return ret == 0;
		}
	}
}