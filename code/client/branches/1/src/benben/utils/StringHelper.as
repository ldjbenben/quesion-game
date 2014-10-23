package benben.utils
{
	public class StringHelper
	{
		/**
		 * Uppercase the first character in a string
		 */
		public static function ucword(str:String):String
		{
			return str.charAt(0).toUpperCase() + str.substr(1);
		}
	}
}