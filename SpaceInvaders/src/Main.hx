package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.display.BitmapData;
import flash.display.Bitmap;
import openfl.Assets;




/**
 * ...
 * @author Nicholas Seward
 */

class Main extends Sprite 
{
	var inited:Bool;
	var ship:Ship;
	var leftDown:Bool;
	var rightDown:Bool;
	public static var game:Main;
	public var bullets:List<Bullet>;

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

	/* SETUP */

	public function new() 
	{
		super();
		game = this;
		bullets = new List<Bullet>();
		addEventListener(Event.ADDED_TO_STAGE, added);
		//Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, move);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, processKey);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, processUpKey);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, doStuff);
		ship = new Ship(400,400);
		this.addChild(ship);
	}
	
	function doStuff(e)
	{
		if (leftDown) ship.left();
		if (rightDown) ship.right();
		
		ship.act();
		for (bullet in bullets) bullet.act();
		trace(bullets.length);
		
	}
	
	function processKey(e:KeyboardEvent)
	{
		trace(e.keyCode);
		if (e.keyCode == 37) leftDown = true;
		if (e.keyCode == 39) rightDown = true;
		if (e.keyCode == 32) ship.shoot();
		if (e.keyCode == 192) for (bullet in bullets) bullet.explode();
	}
	
	function processUpKey(e:KeyboardEvent)
	{
		trace(e.keyCode);
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
