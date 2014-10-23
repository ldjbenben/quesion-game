package application.display
{
	import application.display.dialog.Dialog;
	import application.views.BaseView;

	public class UIManager
	{
		public static function showDialog(dialog:Dialog, scene:BaseView):void
		{
			var x:Number = (scene.width - dialog.width)/2;
			var y:Number = (scene.height - dialog.height)/2;
			scene.addChild(dialog);
			dialog.x = x;
			dialog.y = y;
		}
	}
}