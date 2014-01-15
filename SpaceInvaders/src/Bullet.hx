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
class Bullet extends Sprite
{
	var goingUp:Bool;
	var countdownToDestruction:Int;
	
	public function new(x:Int, y:Int, goingUp:Bool) 
	{
		super();
		this.goingUp = goingUp;
		var img = new Bitmap(Assets.getBitmapData("img/bullet.png"));
        addChild(img);
		this.width = 25;
		this.height = 25;
		this.x = x;
		this.y = y;
		countdownToDestruction = -1;
	}
	
	public function explode()
	{
		countdownToDestruction = 60;
		this.removeChildAt(0);
		var img = new Bitmap(Assets.getBitmapData("img/kapow.png"));
        addChild(img);
	}
	
	
	public function act()
	{
		if (countdownToDestruction < 0)
		{
			if (goingUp) this.y -= 3;
			else this.y += 3;
		}
		else
		{
			this.alpha = countdownToDestruction / 60.0;
			countdownToDestruction -= 1;
		}
		if (countdownToDestruction == 0 || this.y<-this.height)
		{
			Main.game.bullets.remove(this);
			Main.game.removeChild(this);
		}
	}
	
}