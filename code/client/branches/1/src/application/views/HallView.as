package application.views
{
	import benben.Benben;
	
	import bui.controls.HGroup;
	import bui.controls.HScrollBar;
	import bui.controls.List;
	import bui.controls.VGroup;
	import bui.controls.VScrollBar;
	import bui.skins.ben.ScrollArrowSkin;
	
	import flash.display.Sprite;
	import flash.errors.EOFError;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	
	public class HallView extends BaseView
	{
		private var _chessboards:Array;
		
		override public function init():void
		{
			super.init();
			_chessboards = new Array();
		}
		
		override public function enter():void
		{
			Benben.app.connector.request("getTables", getTablesResponse); 
		}
		
		private function getTablesResponse(bytes:ByteArray):void
		{
			var b:int;
			var item:Sprite;
			var i:int;
			try
			{
				while(true)
				{
					b = bytes.readByte();
					item = Benben.app.assetsLoader.getImgFromPackage("HallUiRes", "chessboard_ico1");
					_chessboards.push(item);
					item.x += i*item.width;
					//addChild(item);
					i++;
				}
			}
			catch(exp:EOFError)
			{
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
				
				
				var list:List = new List();
				
				list.layout.columnWidth = 50;
				list.layout.columnCount = 4;
				list.layout.rowHeight = 50;
				
				list.addItem(new ScrollArrowSkin(0xff0000));
				list.addItem(new ScrollArrowSkin(0x00ff00));
				list.addItem(new ScrollArrowSkin(0x0000ff));
				list.addItem(new ScrollArrowSkin(0xffff00));
				list.addItem(new ScrollArrowSkin(0x0000ff));
				list.addItem(new ScrollArrowSkin(0xffff00));
				list.addItem(new ScrollArrowSkin(0x0000ff));
				list.addItem(new ScrollArrowSkin(0xffff00));
				list.addItem(new ScrollArrowSkin(0xffff00));
				list.addItem(new ScrollArrowSkin(0x0000ff));
				list.addItem(new ScrollArrowSkin(0xffff00));
				
				list.x = 100;
				list.y = 200;
				addChild(list);
				
				var t:Timer = new Timer(2000, 10);
				t.addEventListener(TimerEvent.TIMER, function(evt:TimerEvent):void{
					//vGroup.removeElement(1);
					//hGroup.removeElement(1);
					list.removeItem(1);
					trace("width:"+list.width+" height:"+list.height);
				});
				t.start();
				
//				vGroup.addElement(new ScrollArrowSkin(0xf000ff));
				/*
				var data:Array = new Array();
				for(var j:int; j<10; j++)
				{
					data.push(new ScrollArrowSkin());
				}
				var tables:List = new List();
				tables.columnCount = 3;
				tables.dataProvider = data;
				tables.cellPadding = 10;
				addChild(tables);
				*/
				
				/*
				var vScroll:VScrollBar = new VScrollBar();
				vScroll.y = 0;
				vScroll.scrollSize = 300;
				vScroll.scrollThickness = 20;
				addChild(vScroll);
				
				var hScroll:HScrollBar = new HScrollBar();
				hScroll.x = 300;
				hScroll.y = 100;
				hScroll.scrollSize = 300;
				hScroll.scrollThickness = 20;
				*/
				//addChild(hScroll);
			}
		}
	}
}