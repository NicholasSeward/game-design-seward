package ;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;

/**
 * ...
 * @author Nicholas Seward
 */
class Ship extends Sprite
{

	public function new(x:Int, y:Int) 
	{
		super();
		var img = new Bitmap(Assets.getBitmapData("img/squirrel.jpg"));
        addChild(img);
		this.width = 25;
		this.height = 25;
		this.x = x;
		this.y = y;
	}
	
}