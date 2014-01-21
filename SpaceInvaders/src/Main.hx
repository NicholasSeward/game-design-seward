package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.text.TextField;
import flash.text.TextFormat;
import openfl.Assets;




/**
 * ...
 * @author Nicholas Seward
 */

class Main extends Sprite 
{
	var inited:Bool;
	public var ship:Ship;
	var leftDown:Bool;
	var rightDown:Bool;
	public static var game:Main;
	public var bullets:List<Bullet>;
	public var enemies:List<Enemy>;
	var counter:Int;
	var menu:Sprite;
	var p:TextField;

	/* ENTRY POINT */
	
	function resize(e)
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		//var img = new Bitmap(Assets.getBitmapData("img/squirrel.jpg"));
        //addChild(img);
		//this.x = 10;
	}
	
	public function displayMenu()
	{
		this.addChild(menu);
		
	}

	/* SETUP */

	public function new() 
	{
		super();
		game = this;
		bullets = new List<Bullet>();
		enemies = new List<Enemy>();
		counter = 0;
		menu = new Sprite();
		menu.graphics.beginFill(0xFFFFFF, .25);
		menu.graphics.drawRect(0, 0, 800, 480);
		var ts = new TextFormat();
        ts.font = "Ubuntu";
        ts.size = 40;               
        ts.color=0xFFFFFF;
        p = new TextField();
        p.text = 'Play Again';
		p.width = 500;
        p.setTextFormat(ts);
        menu.addChild(p);
		p.y = 100;
		p.x = 50;
		
		
		addEventListener(Event.ADDED_TO_STAGE, added);
		//Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, move);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, processKey);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, processUpKey);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, doStuff);
		p.addEventListener(MouseEvent.MOUSE_DOWN, playAgain_mouse);
		ship = new Ship(400,400);
		this.addChild(ship);
		makeEnemies();
		
	}
	
	public function playAgain()
	{
		while (this.numChildren > 0) this.removeChildAt(0);
		this.addChild(ship);
		bullets = new List<Bullet>();
		enemies = new List<Enemy>();
		ship.reanimate();
		makeEnemies();
		Lib.current.stage.focus = this;
		this.focusRect = false;
	}
	
	public function playAgain_mouse(e:MouseEvent)
	{
		playAgain();
	}
	
	public function makeEnemies()
	{
		for ( i in 0...6 )
		{
			var enemy = new Enemy(Std.int(100+600/5*i), 100);
			this.addChild(enemy);
			enemies.add(enemy);
		}
	}
	
	function doStuff(e)
	{
		counter += 1;
		if (leftDown) ship.left();
		if (rightDown) ship.right();
		ship.act();
		for (bullet in bullets) bullet.act();
		//trace(bullets.length);
		for (enemy in enemies) enemy.act();
		
		if (enemies.length<8 && counter % 60 == 0)
		{
			var enemy = new Enemy(Std.int(Math.random()*600+100), 100);
			this.addChild(enemy);
			enemies.add(enemy);
		}
		
	}
	
	function processKey(e:KeyboardEvent)
	{
		trace(e.keyCode);
		if (e.keyCode == 37) leftDown = true;
		if (e.keyCode == 39) rightDown = true;
		if (e.keyCode == 32) ship.shoot();
		if (e.keyCode == 82) playAgain();
		if (e.keyCode == 77) displayMenu();
		if (e.keyCode == 192) for (bullet in bullets) bullet.explode();
	}
	
	function processUpKey(e:KeyboardEvent)
	{
		//trace(e.keyCode);
		if (e.keyCode == 37) leftDown = false;
		if (e.keyCode == 39) rightDown = false;
	}
	
	function move(e:MouseEvent)
	{
		var x = e.stageX;
		var y = e.stageY;
		this.x = x;
		this.y = y;
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
