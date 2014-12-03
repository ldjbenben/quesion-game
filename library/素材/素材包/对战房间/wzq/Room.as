package wzq {
	
	import flash.display.Sprite;
	
	
	public class Room extends Sprite 
	{
		private var __player1_mc:Player;
		private var __player2_mc:Player;
		private var __chessboard:Chessboard;
		
		public function Room() 
		{
			initView();
			__player1_mc.username = "123asd4";
			__player2_mc.username = "player2";
		}
		
		private function initView():void
		{
			__player1_mc = this.getChildByName("player1_mc") as Player;
			__player2_mc = this.getChildByName("player2_mc") as Player;
			__chessboard = this.getChildByName("chessboard") as Chessboard;
			//__chessboard.ownerColor = Chessboard.BLACK;
			//__chessboard.pre = Chessboard.BLACK;
		}
	}
	
}
