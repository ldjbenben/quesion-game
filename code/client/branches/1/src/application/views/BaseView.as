package application.views
{
	import benben.base.View;
	
	import flash.display.Sprite;

	public class BaseView extends View
	{
		/**
		 * 只会被调用一次，在第一次创建场景对象的时候被调用
		 */
		override public function init():void
		{
//			this.graphics.clear();
			this.graphics.beginFill(0x5555FF);
			this.graphics.drawRect(0, 0, 800,600);
			this.graphics.endFill();
		}
	}
}