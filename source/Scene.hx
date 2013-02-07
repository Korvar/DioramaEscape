package ;

import org.flixel.FlxButton;
import org.flixel.FlxSound;
import org.flixel.FlxSound;

/**
 * ...
 * @author Mike Cugley
 */

 typedef Backdrop = {
	 var flags: FlagList; // List of flags that determine if this backdrop is used
	 var graphic: String;
 }
 
 typedef HotSpot = {
	 var flagList: FlagList;  // List of flags that determine if the button is put in the scene
	 var button: FlxButton;  //Maybe I just need x, y, width, height?
	 var flagSetList: FlagList;  // list of flags that the button will set if pushed.
	 var outputString: String; // Message that appears if the button is pressed
	 var scene: String; // Change scene should the button be pressed
	 var sound: FlxSound;  // the onDown sound
	 
	 // Have to think of a way of dealing with inventory objects.
	 // Array of objectname strings that get added?  Array of names that get removed?
	 
 }
 
class Scene 
{
	var backdrops: Array<Backdrop>;  // An array of potential backdrops
	var hotSpots: Array<HotSpot>;  // Array of potential host spots.
	var backdrop: String;  // this is the actual backdrop that will appear

	public function new(_backdrops:Array<Backdrop> = null, _hotSpots:Array<HotSpot> = null) 
	{
		backdrops = _backdrops;
		hotSpots = _hotSpots;
		backdrop = "";
		

		
	}
	
}