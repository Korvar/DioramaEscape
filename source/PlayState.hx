package;

import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSound;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;

/* typedef Backdrop = {
	 var flags: FlagList; // List of flags that determine if this backdrop is used
	 var graphic: String;
 }*/

class PlayState extends FlxState
{
	var flags:FlagList;  // the master flag list
	var hotSpots:FlxGroup;  // All the hot spots go here
	var backDrop:FlxSprite;
	var scenes:Hash<Scene>;
	var flagHash: FlagList;
	
	override public function create():Void
	{
		
		// FlxG.levels[0] is the flag list
		// FlxG.levels[1] is the scene list
		// FlxG.levels[2] is the name of the next scene to go to
		
		flagHash = new FlagList();
	
		FlxG.levels[0] = flagHash;
		
		FlxG.levels[1] = new Hash<Scene>();  //might not need this
		
		
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
				
		#if android
			FlxG.addSound("Beep");
		#end
		
		backDrop = new FlxSprite();
		backDrop.x = 0;
		backDrop.y = 0;
		backDrop.immovable = true;
		add(backDrop);
		
		hotSpots = new FlxGroup(0);
		add(hotSpots);
		
		setupScenes();
		FlxG.levels[0].set("SceneChange", true);  //Trigger a scene change
		
		FlxG.mouse.show("assets/data/pointer-yellow.png");

	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		
		// Check for Scene change
		if (FlxG.levels[0].get("SceneChange"))
		{
			changeScene(FlxG.levels[1].get(FlxG.levels[2]));
			FlxG.levels[0].set("SceneChange", false);  // otherwise we'll change scenes forever!
		}
	}
	
	
	function setupScenes()
	{
		var tempBackdropFlagList: FlagList;
		var tempBackdrop: Backdrop;

		var tempHotSpot: HotSpot;
		var tempHotSpotFlagList: FlagList;
		var tempHotSpotSetFlagList: FlagList;

		var sceneName: String;
		
		var backDropList: Array<Backdrop> = new Array<Backdrop>();
		var hotSpotList: Array<HotSpot> = new Array<HotSpot>();

		
		// Starter scene
		sceneName = "SamuraiWideView";

		// Hotspot
		tempHotSpotFlagList = new FlagList();
		tempHotSpotSetFlagList = new FlagList();
		tempHotSpotSetFlagList.set("SceneChange", true); // Pressing this button will trigger a scene change
		tempHotSpot = new HotSpot(142, 83, 124, 110, tempHotSpotFlagList, tempHotSpotSetFlagList, "", "SamuraiCloseUp", null);
		hotSpotList.push(tempHotSpot);

		// Backdrop
		tempBackdropFlagList = new FlagList();
		// As there is no conditional backdrop, just leave the FlagList as default	
		tempBackdrop = { graphic: "assets/data/SamuraiWideAngle.jpg", flags: tempBackdropFlagList };
		backDropList.push(tempBackdrop);
		
		var firstScene: Scene = new Scene(backDropList, hotSpotList);
		
		FlxG.levels[1].set(sceneName, firstScene);
		
		FlxG.levels[2] = "SamuraiWideView";  // This is the starting view
	}
	
	function changeScene(newScene:Scene)
	{
		var backDropName: String = "";
		
		#if debug
		trace(newScene.backdrops.toString());
		#end
		
		for (bd in newScene.backdrops)
		{
			#if debug
			trace(bd.graphic);
			trace(bd.flags.toString());
			#end
			
			if (bd.flags.checkFlags())
			{
				backDropName = bd.graphic;
			}
			
			if (backDropName == "")
			{
				// Oh god it's gone wrong
				// should probably come up with a "you fucked up!" graphic for this case.
				backDrop.makeGraphic(640, 480, 0xffff0000);  // Big red screen
				#if debug
				trace("Graphic load failed");
				trace(backDropName);
				#end
			}
			else
			{
				backDrop.loadGraphic(backDropName, false, false, 640, 480); // Should have a Backdrop height / width variable.
				#if debug
				trace("Graphic load reached");
				trace(backDropName);
				#end
			}
		}
		
		for (hs in newScene.hotSpots)
		{
			if (hs.flagSetList.checkFlags())
			{
				hotSpots.add(hs);
			}
		}
		
		#if debug
		trace("Scene changed!");
		trace(newScene);
		#end
	}
}
