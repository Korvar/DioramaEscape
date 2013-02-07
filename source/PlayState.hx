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

class PlayState extends FlxState
{
	var flags:FlagList;  // the master flag list
	var hotSpots:FlxGroup;  // All the hot spots go here
	var backDrop:FlxSprite;
	var scenes:Hash<Scene>;
	
	override public function create():Void
	{
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
		
		FlxG.mouse.show("assets/data/pointer-yellow.png");
		
				
		var testButton = new FlxButton(FlxG.width / 2, FlxG.height / 2, "");
		testButton.alpha = 0;
		testButton.label.alpha = 0;
		add(testButton);
		//var onOver = Assets.getSound("Beep");
		//testButton.setSounds(onOver);
		testButton.onOver = function(){
				FlxG.mouse.show("assets/data/pointer-green.png");
			};	
		testButton.onOut = function() {
				FlxG.mouse.show("assets/data/pointer-yellow.png");
			};
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		
		// Check for Scene change
	}	
	
	function setupScenes()
	{
		var tempBackdropFlagList: FlagList;
		var tempHotSpotFlagList: FlagList;
		var tempHotSpotSetFlagList: FlagList;
		
		
		// Starter scene
		tempBackdropFlagList = new FlagList();
		tempHotSpotFlagList = new FlagList();
		tempHotSpotSetFlagList = new FlagList();
		
		
		setupScenes = new Scene();
		
		
	}
	
	function changeScene(newScene:Scene)
	{
		var backDropName: String;
		
		for (bd in newScene.backdrops)
		{
			if (bd.flags.checkFlags())
			{
				backDropName = bd.graphic;
			}
			
			if (backdrop == "")
			{
				// Oh god it's gone wrong
				// should probably come up with a "you fucked up!" graphic for this case.
				backDrop.makeGraphic(640, 480, 0xffff0000);  // Big red screen
			}
			else
			{
				backDrop.loadGraphic(backDropName, false, false, 640, 480); // Should have a Backdrop height / width variable.
			}
		}
		
		for (hs in newScene.hotSpots)
		{
			if (hs.flagSetList.checkFlags())
			{
				hotSpots.add(hs.button);
			}
		}
	}
}