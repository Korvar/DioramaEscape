package ;

/**
 * ...
 * @author Mike Cugley
 */

 
import org.flixel.FlxButton;
import org.flixel.FlxSound;
import org.flixel.FlxG;
 
class Item extends HotSpot
{
	var inUse: Bool;
	

	public function new(X:Float, Y:Float, Width:Float, Height:Float, Flags:FlagList, SetFlags:FlagList, OutputString:String, ItemDetail:String, Sound:FlxSound) 
	{
		super(X, Y, Width, Height, Flags, SetFlags, OutputString, ItemDetail, Sound);
		alpha = 1;  // Items, unlike hotspots, are visible
		inUse = false;
		
		makeGraphic(95, 95);
		
		onDown = function() {
			FlxG.mouse.show("assets/data/pointer-yellow.png");
			flagSetList.setFlags();
			
			if (inUse == false)
			{
				inUse == true;
				// Somehow set inUse to all the other items to false.
			}
			else 
			{
				inUse == false;
				flagSetList.setFlags();

			}
		};
	}
}