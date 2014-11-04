package application.views
{
	import application.config.ApplicationConfig;
	import application.display.button.SimpleButton;
	import application.display.obstacle.Pillar;
	import application.display.player.Player;
	
	import benben.Benben;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.Timer;

	public class MainView extends BaseView
	{
		private var _pillars:Array;
		private var _people:Player;
		private var _animatePillarsTimer:Timer;
		private var _createPillarsTimer:Timer;
		private var _peopleTimer:Timer;
		private var _startButton:SimpleButton;
		private var _peopleDownTime:uint;
		private var _peopleSpeed:int = 0;
		//private var _
		
		override public function init():void
		{
			super.init();
			_startButton = new SimpleButton(100,60);
			_startButton.x = 100;
			_startButton.y = 350;
			addChild(_startButton);
			_startButton.addEventListener(MouseEvent.CLICK, onStartButtonClick);
			onStartButtonClick(null);
		}
		
		override public function enter():void
		{
			_people = new Player();
			_people.x = 100;
			_people.y = 200;
			//addChildAt(_people,2);
			addChild(_people);
		}
		
		private function onStartButtonClick(evt:Event):void
		{
			//removeChild(_startButton);
			//run();
			var data:Array = new Array();
			data.push(100);
			Benben.app.socket.connect();
			
			/*
			Benben.app.socket.writeInt(2);
			Benben.app.socket.writeInt(100);
			Benben.app.socket.writeInt(200);
			Benben.app.socket.writeInt(300);
			Benben.app.socket.sendRequest(2, testResponse); 
			//set(key, value, );
			*/
		}
		
		private function testResponse(so:Socket):void
		{
			trace("ccada");
		}
		
		private function run():void
		{
			_pillars = new Array();
			
			addEventListener(Event.ENTER_FRAME, animatePillars)
			
			// 创建柱子
			createPillars();
			
			// 添加单击事件
			addEventListener(MouseEvent.CLICK, onMouseClick);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			// 柱子移动动画
			//_animatePillarsTimer = new Timer(5);  
			//_animatePillarsTimer.addEventListener(TimerEvent.TIMER, animatePillars);
			//_animatePillarsTimer.start();
			
		
			var date:Date = new Date();
			_peopleDownTime = date.getUTCMilliseconds();
		
			// 小人降落动画
			_peopleTimer = new Timer(100);
			_peopleTimer.addEventListener(TimerEvent.TIMER, animatePeople);
			_peopleTimer.start();
		}
		
		private function onMouseClick(evt:Event):void
		{
			_people.y -= 45;
		}
		
		private function onMouseDown(evt:Event):void
		{
			_peopleTimer.stop();
			_peopleSpeed = 0;
		}
		
		private function onMouseUp(evt:Event):void
		{
			_peopleTimer.start();
		}
		
		private function animatePeople(evt:Event):void
		{
			_peopleSpeed+=8;
			_people.y += _peopleSpeed;
		}
		
		private function createPillars():void
		{
			_createPillarsTimer = new Timer(4000);
			_createPillarsTimer.addEventListener(TimerEvent.TIMER, createPillarsTimerHandler);
			_createPillarsTimer.start();
		}
		
		private function createPillarsTimerHandler(evt:Event):void
		{
			var h1:uint = Math.round(Math.random()*300);
			var h2:uint = height-h1-150;
			//createPillars(h1,h2);
			
			
			var p:Pillar = new Pillar();
			_pillars.push(p);
			p.height = h1;
			p.x = 800;
			p.y = 0;
			addChildAt(p,0);
			
			var p2:Pillar = new Pillar();
			_pillars.push(p2);
			p2.height = h2;
			p2.x = 800;
			p2.y = height-p2.height;
			addChildAt(p2,0);
		}
		
		private function animatePillars(evt:Event):void
		{
			for(var i:uint=0; i<_pillars.length; i++)
			{
				_pillars[i].x -= 3;
				if(_people.hitTestObject(_pillars[i]))
				{
					over();
				}
			}
		}
		
		private function over():void
		{
			//_animatePillarsTimer.stop();
			_createPillarsTimer.stop();
		}
		/*
		private function createPillars(h1:uint, h2:uint):void
		{
			var p:Pillar = new Pillar();
			_pillars.push(p);
			p.height = h1;
			p.x = 800;
			p.y = 0;
			addChildAt(p,0);
			
			var p2:Pillar = new Pillar();
			_pillars.push(p2);
			p2.height = h2;
			p2.x = 800;
			p2.y = height-p2.height;
			addChildAt(p2,0);
		}
		*/
	}
}