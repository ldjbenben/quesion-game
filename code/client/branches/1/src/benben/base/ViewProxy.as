package benben.base
{
	public class ViewProxy
	{
		protected var _view:View;
		
		public function ViewProxy(view:View)
		{
			_view = view;
		}
		
		public function init():void
		{
		}
		
		public function get view():View
		{
			return _view;
		}

	}
}