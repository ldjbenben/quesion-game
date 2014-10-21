package
{
	import flash.display.Sprite;
	
	import benben.net.CustomSocket;
	
	[SWF(width=700, height=600)]
	public class Main extends Sprite
	{
		private var socket:CustomSocket;
		
		public function Main()
		{
//			socket = new CustomSocket("192.168.1.130", 9999);
			socket = new CustomSocket("192.168.1.155", 9999);
		}
	}
}