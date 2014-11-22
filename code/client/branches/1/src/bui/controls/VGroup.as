package bui.controls
{
	import bui.layouts.VerticalLayout;
	
	public class VGroup extends Group
	{
		public function VGroup()
		{
			_layout = new VerticalLayout();
			_layout.target = this;
		}
	}
}