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
	
	public function new(x:Int, y:Int) 
	{
		super();
		var img = new Bitmap(Assets.getBitmapData("img/squirrel.jpg"));
        addChild(img);
		this.width = 50;
		this.height = 50;
		this.x = x;
		this.y = y;
		this.v = 0;
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
		var b:Bullet = new Bullet(Std.int(this.x + this.width / 2), Std.int(this.y), true);
		Main.game.bullets.add(b);
		Main.game.addChild(b);
		//create a bullet in front of the ship
	}
	
	public function act()
	{
		if (this.x < 0 && this.v<0) this.v = 0;
		if (this.x > 800 - this.width && this.v>0) this.v = 0;
		this.v *= .9;
		this.x += this.v;
	}
	
}