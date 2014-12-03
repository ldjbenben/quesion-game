package application.display.items
{
	import benben.Benben;
	
	import bui.base.UIComponent;
	
	import flash.display.Sprite;
	
	public class PlayerHead extends UIComponent
	{
		public static const STATEMENT_NO_ONE:String = "no_one";
		public static const STATEMENT_BOY:String = "boy";
		public static const STATEMENT_GIRL:String = "girl";
		public static const BOY:String = "boy";
		public static const GIRL:String = "girl";
		public static const STATEMENT_UNKNOWN:String = "unknown";
		
		private var _boy:Sprite;
		private var _girl:Sprite;
		private var _unknown:Sprite;
		private var _noOne:Sprite;
		private var _sex:String;
		
		public function PlayerHead()
		{
			registerStatement(STATEMENT_BOY, boyStatement);
			registerStatement(STATEMENT_GIRL, girlStatement);
			registerStatement(STATEMENT_UNKNOWN, unknownStatement);
			registerStatement(STATEMENT_NO_ONE, noOneStatement);
			/*
			switch(type)
			{
				case STATEMENT_BOY:
					statement = STATEMENT_NO_ONE;
					break;
				case STATEMENT_GIRL:
					statement = STATEMENT_NO_ONE;
					break;
				case STATEMENT_UNKNOWN:
					statement = STATEMENT_NO_ONE;
					break;
				case STATEMENT_NO_ONE:
					statement = STATEMENT_NO_ONE;
					break;
			}
			*/
		}

		private function boyStatement(enter:Boolean):void
		{
			_sex = BOY;
			if(enter)
			{
				if(_boy == null)
				{
					_boy = Benben.app.assetsLoader.getImgFromPackage("HallUiRes", "head_boy");
				}
				addChild(_boy);
			}
			else
			{
				removeChild(_boy);
			}
		}

		private function girlStatement(enter:Boolean):void
		{
			_sex = GIRL;
			if(enter)
			{
				if(_girl == null)
				{
					_girl = Benben.app.assetsLoader.getImgFromPackage("HallUiRes", "head_girl");
				}
				addChild(_girl);
			}
			else
			{
				removeChild(_girl);
			}
		}

		private function unknownStatement(enter:Boolean):void
		{
			if(enter)
			{
				if(_unknown == null)
				{
					_unknown = Benben.app.assetsLoader.getImgFromPackage("HallUiRes", "head_noOne");
				}
				addChild(_unknown);
			}
			else
			{
				removeChild(_unknown);
			}
		}

		private function noOneStatement(enter:Boolean):void
		{
			if(enter)
			{
				if(_noOne == null)
				{
					_noOne = Benben.app.assetsLoader.getImgFromPackage("HallUiRes", "head_noOne");
				}
				addChild(_noOne);
			}
			else
			{
				removeChild(_noOne);
			}
		}

	}
}