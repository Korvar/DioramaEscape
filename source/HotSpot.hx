package ;

/**
 * ...
 * @author Mike Cugley
 */

import org.flixel.FlxButton;
import org.flixel.FlxSound;
import org.flixel.FlxG;
 
class HotSpot extends FlxButton
{

	public var flagList: FlagList;  // List of flags that determine if the button is put in the scene
	public var flagSetList: FlagList;  // list of flags that the button will set if pushed.
	public var outputString: String; // Message that appears if the button is pressed
	public var scene: String; // Change scene should the button be pressed
	public var sound: FlxSound;  // the onDown sound
	
		 
	 // Have to think of a way of dealing with inventory objects.
	 // Array of objectname strings that get added?  Array of names that get removed?
	
	override public function new(X:Float, Y:Float, Width:Float, Height:Float, Flags:FlagList, SetFlags:FlagList, OutputString:String, NewScene:String, Sound:FlxSound) 
	{
		super(X, Y, "");
		flagList = Flags;
		width = Width;
		height = Height;
		alpha = 0;
		label.alpha = 0;
		flagSetList = SetFlags;
		outputString = OutputString;
		scene = NewScene;
		soundDown = Sound;
		
		onOver = function(){
			FlxG.mouse.show("assets/data/pointer-green.png");
		};	
		onOut = function() {
			FlxG.mouse.show("assets/data/pointer-yellow.png");
		};
		onDown = function() {
			flagSetList.setFlags();
			// Set the output string, if need be
			};
		
	}
	
}




	 
