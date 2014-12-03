package application.display.items
{
	import benben.Benben;
	
	import bui.base.UIComponent;
	
	import flash.display.Sprite;
	
	public class Chessboard extends UIComponent
	{
		public static const STATEMENT_EMPTY:String = "empty";
		public static const STATEMENT_BUSY:String = "busy";
		
		private var _emptyStatement:Sprite;
		private var _busyStatement:Sprite;
		
		public function Chessboard(type:String = STATEMENT_EMPTY)
		{
			registerStatement(STATEMENT_EMPTY, emptyStatement);
			registerStatement(STATEMENT_BUSY, busyStatement);
			/*
			if(type == STATEMENT_EMPTY)
			{
				statement = STATEMENT_EMPTY;
			}
			else if(type == STATEMENT_BUSY)
			{
				statement = STATEMENT_BUSY;
			}
			*/
		}
		
		private function emptyStatement(enter:Boolean):void
		{
			if(enter)
			{
				if(_emptyStatement == null)
				{
					_emptyStatement = Benben.app.assetsLoader.getImgFromPackage("HallUiRes", "chessboard_empty");
				}
				addChild(_emptyStatement);
			}
			else
			{
				removeChild(_emptyStatement);
			}
		}
		
		private function busyStatement(enter:Boolean):void
		{
			if(enter)
			{
				if(_busyStatement == null)
				{
					_busyStatement = Benben.app.assetsLoader.getImgFromPackage("HallUiRes", "chessboard_busy");
				}
				addChild(_busyStatement);
			}
			else
			{
				removeChild(_busyStatement);
			}
		}
	}
}