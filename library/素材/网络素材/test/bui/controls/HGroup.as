package bui.controls
{
	import bui.layouts.HorizontalLayout;

	public class HGroup extends Group
	{
		public function HGroup()
		{
			_layout = new HorizontalLayout();
			_layout.target = this;
		}
	}
}