package  {
	
	import bui.controls.HGroup;
	import bui.controls.VGroup;
	import bui.controls.VScrollBar;
	import bui.skins.ben.ScrollArrowSkin;
	
	import flash.display.Sprite;
	
	
	public class Main extends Sprite 
	{
		public function Main() 
		{
			// constructor code
			/*
			var vScroll:VScrollBar = new VScrollBar();
			vScroll.y = 0;
			vScroll.scrollSize = 300;
			vScroll.scrollThickness = 20;
			addChild(vScroll);
			*/
			
			var vGroup:VGroup = new VGroup;
			
			vGroup.border = true;
			addChild(vGroup);
			vGroup.addElement(new ScrollArrowSkin(0xff0000));
			vGroup.addElement(new ScrollArrowSkin(0x00ff00));
			vGroup.addElement(new ScrollArrowSkin(0x0000ff));
			vGroup.addElement(new ScrollArrowSkin(), 0);
			vGroup.addElement(new ScrollArrowSkin(0xf000ff));
			
			
			
			var hGroup:HGroup = new HGroup;
			
			hGroup.border = true;
			hGroup.x = 100;
			addChild(hGroup);
			hGroup.addElement(new ScrollArrowSkin(0xff0000));
			hGroup.addElement(new ScrollArrowSkin(0x00ff00));
			hGroup.addElement(new ScrollArrowSkin(0x0000ff));
			hGroup.addElement(new ScrollArrowSkin(), 0);
			hGroup.addElement(new ScrollArrowSkin(0xf000ff));
		}
	}
	
}
