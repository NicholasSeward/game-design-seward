package ;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import flash.Lib;

/**
 * ...
 * @author Nicholas Seward
 */
class Ship extends Sprite
{

	var v:Float;
	public var isAlive:Bool;
	var health:Int;
	var MAX_HEALTH = 5;
	var health_bar:Sprite;
	
	public function new(x:Int, y:Int) 
	{
		super();
		health = MAX_HEALTH;
		isAlive = true;
		var img = new Bitmap(Assets.getBitmapData("img/ship.png"));
		var sprite = new Sprite();
        sprite.addChild(img);
		sprite.x = -img.width / 2;
		sprite.y = -img.height / 2;
		this.addChild(sprite);
		health_bar = new Sprite();
		health_bar.graphics.beginFill(0x00FF00, .5);
        health_bar.graphics.drawRect(0, 0, img.width, 5);
		sprite.addChild(health_bar);
		health_bar.y = -8;
		//sprite.addChild(health_bar);*/
    
		this.x = x;
		this.y = y;
		this.v = 0;
	}
	
	public function reanimate()
	{
		isAlive = true;
		health = MAX_HEALTH;
	}
	
	public function left()
	{
		this.v-= 1;
	}
	
	public function right()
	{
		this.v += 1;
	}
	
	public function shoot()
	{
		if (isAlive)
		{
			var b:Bullet = new Bullet(Std.int(this.x), Std.int(this.y-this.height/2), true);
			Main.game.bullets.add(b);
			Main.game.addChild(b);
			//create a bullet in front of the ship
		}
	}
	
	public function kill()
	{
		this.health -= 1;
		if (health <= 0)
		{
			Main.game.displayMenu();
			Main.game.removeChild(this);
			isAlive = false;
		}
	}
	
	public function act()
	{
		health_bar.width = 44 * health / MAX_HEALTH;
		if (this.x < this.width/2 && this.v < 0)
		{
			this.v = 0;
			this.x = this.width/2;
		}
		if (this.x > 800 - this.width/2 && this.v > 0)
		{
			this.v = 0;
			this.x = 800 - this.width/2;
		}
		this.v *= .9;
		this.x += this.v;
	}
	
}