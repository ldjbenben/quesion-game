package benben.base
{
	import flash.display.Sprite;
	
	public class Stage extends Sprite
	{
		protected var _stage_width:Number = 900;
		protected var _stage_height:Number = 600;
		
		public function get stage_width():Number
		{
			return _stage_width;
		}

		public function get stage_height():Number
		{
			return _stage_height;
		}


	}
}