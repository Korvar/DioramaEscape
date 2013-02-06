package ;

import org.flixel.FlxButton;

/**
 * ...
 * @author Mike Cugley
 */

 typedef backdrop = {
	 var flagList: Hash<Bool>; // List of flags that determine if this backdrop is used
	 var graphic: String;
 }
 
 typedef hotSpot = {
	 var flagList: Hash<Bool>;  // List of flags that determine if the button is put in the scene
	 var button: FlxButton;
	 var flagSetList: Hash<Bool>;  // list of flags that the button will set if pushed.
 }
 
class Scene 
{
	var backdrops: Array<backdrop>;
	

	public function new() 
	{
		
	}
	
}