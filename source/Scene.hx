package ;

import org.flixel.FlxButton;
import org.flixel.FlxSound;
import org.flixel.FlxSound;

/**
 * ...
 * @author Mike Cugley
 */

 
class Scene 
{
	public var backdrops: Array<Backdrop>;  // An array of potential backdrops
	public var hotSpots: Array<HotSpot>;  // Array of potential host spots.
	public var backdrop: String;  // this is the actual backdrop that will appear

	public function new(_backdrops:Array<Backdrop> = null, _hotSpots:Array<HotSpot> = null) 
	{
		backdrops = _backdrops;
		hotSpots = _hotSpots;
		backdrop = "";
	}

}