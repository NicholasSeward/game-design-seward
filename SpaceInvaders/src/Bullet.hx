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
        var sprite = new Sprite();
        sprite.addChild(img);
		sprite.x = -img.width / 2;
		sprite.y = -img.height / 2;
		this.addChild(sprite);
		this.width = 25;
		this.height = 25;
		this.x = x;
		this.y = y;
		if (!goingUp) this.rotation = 180;
		countdownToDestruction = -1;
	}
	
	public function explode()
	{
		countdownToDestruction = 60;
		this.removeChildAt(0);
		var img = new Bitmap(Assets.getBitmapData("img/kapow.png"));
        var sprite = new Sprite();
        sprite.addChild(img);
		sprite.x = -img.width / 2;
		sprite.y = -img.height / 2;
		this.addChild(sprite);
	}
	
	
	public function act()
	{
		if (countdownToDestruction < 0)
		{
			for (bullet in Main.game.bullets)
			{
				var d = Math.sqrt((this.x - bullet.x) * (this.x - bullet.x) + (this.y - bullet.y) * (this.y - bullet.y));
				if (this.goingUp != bullet.goingUp && d<5 && bullet.countdownToDestruction<0)
				{
					this.explode();
					bullet.explode();
					return;
				}
			}
			
			if (goingUp)
			{
				this.y -= 3;
				for (enemy in Main.game.enemies)
				{
					var d = Math.sqrt((this.x - enemy.x) * (this.x - enemy.x) + (this.y - enemy.y) * (this.y - enemy.y));
					if (d < 30)
					{
						this.explode();
						enemy.kill();
					}
				}
			}
			else
			{
				this.y += 3;
				var ship = Main.game.ship;
				if (ship.isAlive)
				{
					var d = Math.sqrt((this.x - ship.x) * (this.x - ship.x) + (this.y - ship.y) * (this.y - ship.y));
					if (d < 30)
					{
						this.explode();
						ship.kill();
					}
				}
			}
		}
		else
		{
			this.alpha = countdownToDestruction / 60.0;
			countdownToDestruction -= 1;
		}
		if (countdownToDestruction == 0 || this.y<-this.height || this.y>480+this.height)
		{
			Main.game.bullets.remove(this);
			Main.game.removeChild(this);
		}
		
		
	}
	
}