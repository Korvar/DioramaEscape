package ;

import org.flixel.FlxText;
import org.flixel.FlxTimer;

/**
 * ...
 * @author Mike Cugley
 */

class FadeText extends FlxText
{
	var fading:Bool;
	var clock: FlxTimer;
	
	public function new(X : Float, Y : Float, Width : Int, ?Text : String, ?EmbeddedFont : Bool) 
	{
		super(X, Y, Width, Text, EmbeddedFont);
		clock = new FlxTimer();
	}
	
	override public function setText(newText:String):String
	{
		super.setText(newText);
		alpha = 1;
		clock.start(5);
		return newText;
	}
	
	override public function update()
	{
		if (!clock.finished)
		{
			// text = Std.string(alpha) + " " + Std.string(clock.timeLeft);
			if (clock.timeLeft <= 1.0)
			{
				alpha = clock.timeLeft; //alpha = how much of last second is left (I hope!)
			}
		}
		else
		{
			alpha = 0;
		}
		super.update();
	}
}