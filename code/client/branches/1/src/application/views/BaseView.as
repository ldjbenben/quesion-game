package application.views
{
	import benben.Benben;
	import benben.base.View;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class BaseView extends View
	{
		private var _bg:Sprite;
		
		override public function init():void
		{
			//this.graphics.beginFill(0xffffff);
			//this.graphics.drawRect(0, 0,  Benben.app.stage.STAGE_WIDTH, Benben.app.stage.STAGE_HEIGHT);
			//this.graphics.endFill();
			_bg = Benben.app.assetsLoader.getImgFromPackage("HallUiRes", "background");
			_bg.width = Benben.app.stage.stage_width;
			_bg.height = Benben.app.stage.stage_height;
			addChild(_bg);
		}
	}
}