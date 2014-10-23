package benben.base
{
	import flash.display.Sprite;
	
	public class View extends Sprite
	{
		/**
		 * 第一次实例化时调用，只会被调用一次
		 */
		public function init():void
		{}
		
		/**
		 * 每次切换入视图时调用
		 */
		public function enter():void
		{}
		
		/**
		 * 每次切换出视图时调用
		 */
		public function out():void
		{}
		
		/**
		 * 视图被销毁时调用
		 */
		public function destroy():void
		{}
	}
}