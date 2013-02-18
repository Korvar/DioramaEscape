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
	var HUD:FlxGroup; // All the controls stuff
	var hudOverlay:FlxSprite;
	var inventoryBackdrop:FlxSprite;
	var scenes:Hash<Scene>;
	var items:Hash<Item>;
	var itemGroup:FlxGroup;
	var flagHash: FlagList;
	var SceneChangingFlag: Bool = false;
	var messageText: FadeText;
	
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
		backDrop.x = 30;
		backDrop.y = 30;
		backDrop.immovable = true;
		add(backDrop);
		
		// Inventory Detail Screen
		inventoryBackdrop = new FlxSprite();
		inventoryBackdrop.x = backDrop.x + 60;
		inventoryBackdrop.y = backDrop.y + 60;
		inventoryBackdrop.immovable = true;
		inventoryBackdrop.alpha = 0;
		add(inventoryBackdrop);
		
		hotSpots = new FlxGroup(0);
		add(hotSpots);
		
		itemGroup = new FlxGroup();
		add(itemGroup);
		//setupItems();
		
		
		messageText = new FadeText(30, 650, 975, "Test Text");
		messageText.setFormat(null, 20, 0xFFFFFF, "center");
		add(messageText);		
		
		// Want this last so it's on top of everything else.
		HUD = new FlxGroup();
		hudOverlay = new FlxSprite();
		hudOverlay.loadGraphic("assets/data/Mockup03.png");
		hudOverlay.x = 0;
		hudOverlay.y = 0;
		hudOverlay.immovable = true;
		HUD.add(hudOverlay);
		add(HUD);

		
		
		setupScenes();
		FlxG.levels[0].set("SceneChange", true);  //Trigger a scene change
		
		FlxG.mouse.show("assets/data/pointer-yellow.png");
		
		messageText.setText("This is a test");

	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{

		
		// Check for Scene change
		if (FlxG.levels[0].get("SceneChange") == true && SceneChangingFlag == false)
		{
			SceneChangingFlag = true;
			#if debug
			trace("=============================");
			trace("Scene Change Requested");
			trace(FlxG.levels[0].toString());
			trace(FlxG.levels[1]);
			// trace(FlxG.levels[1].tostring());
			trace(FlxG.levels[2]);
			#end
			
			
			changeScene(FlxG.levels[1].get(FlxG.levels[2]));
			
			#if debug
			trace(FlxG.levels[0].toString());
			trace("================================");
			#end
			
			SceneChangingFlag = false;
			FlxG.levels[0].set("SceneChange", false);  // otherwise we'll change scenes forever!
		}
		
		super.update();
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
		tempHotSpotSetFlagList.set("MempoMoved", false);
		tempHotSpot = new HotSpot(backDrop.x + 142, backDrop.y + 83, 124, 110, tempHotSpotFlagList, tempHotSpotSetFlagList, "", "SamuraiCloseUp", null);
		hotSpotList.push(tempHotSpot);

		// Backdrop
		tempBackdropFlagList = new FlagList();
		// As there is no conditional backdrop, just leave the FlagList as default	
		tempBackdrop = { graphic: "assets/data/SamuraiWideAngle.jpg", flags: tempBackdropFlagList };
		backDropList.push(tempBackdrop);
		
		var firstScene: Scene = new Scene(backDropList, hotSpotList);
		
		FlxG.levels[1].set(sceneName, firstScene);
		
		FlxG.levels[2] = "SamuraiWideView";  // This is the starting view
		
		sceneName = "SamuraiCloseUp";
		// Hotspot
		// Reset everything
		hotSpotList = new Array<HotSpot>();
		tempHotSpotFlagList = new FlagList();
		tempHotSpotFlagList.set("MempoMoved", false);
		tempHotSpotSetFlagList = new FlagList();
		tempHotSpotSetFlagList.set("SceneChange", true); // Pressing this button will trigger a scene change
		tempHotSpotSetFlagList.set("MempoMoved", true); // Pressing this button will move the mempo
		tempHotSpot = new HotSpot(backDrop.x + 196, backDrop.y + 181, 162, 114, tempHotSpotFlagList, tempHotSpotSetFlagList, "You moved the Mempo (mask).", "SamuraiCloseUp", null);
		hotSpotList.push(tempHotSpot);
		
		// Same hotspot as before, except it only shows if the mempo is moved, and puts it back.
		tempHotSpotFlagList = new FlagList();
		tempHotSpotSetFlagList = new FlagList();
		tempHotSpotFlagList.set("MempoMoved", true);
		tempHotSpotSetFlagList.set("SceneChange", true); // Pressing this button will trigger a scene change
		tempHotSpotSetFlagList.set("MempoMoved", false); // Pressing this button will move the mempo back
		tempHotSpot = new HotSpot(backDrop.x + 196, backDrop.y + 181, 162, 114, tempHotSpotFlagList, tempHotSpotSetFlagList, "You put the Mempo back.", "SamuraiCloseUp", null);
		hotSpotList.push(tempHotSpot);
		
		// Backdrop
		backDropList = new Array<Backdrop>();
		tempBackdropFlagList = new FlagList();
		tempBackdropFlagList.set("MempoMoved", false);  //Only show this one if the Mempo hasn't moved
		tempBackdrop = { graphic: "assets/data/SamuraiCloseup01.jpg", flags: tempBackdropFlagList };
		backDropList.push(tempBackdrop);	
		
		tempBackdropFlagList = new FlagList();
		tempBackdropFlagList.set("MempoMoved", true);
		tempBackdrop = { graphic: "assets/data/SamuraiCloseupMempoMoved01.jpg", flags: tempBackdropFlagList };
		backDropList.push(tempBackdrop);
		
		var samuraiCloseupScene: Scene = new Scene(backDropList, hotSpotList); 
		FlxG.levels[1].set(sceneName, samuraiCloseupScene);
		
		#if debug
		trace("Scene Setup Done");
		trace(FlxG.levels[1].toString());
		trace("=======================");
		#end
		
	}
	
	function changeScene(newScene:Scene)
	{
		#if debug
		trace("Scene Change Start");
		trace(FlxG.levels[2]);
		//trace(newScene.backdrops.length);
		trace(newScene);
		trace(FlxG.levels[1].toString());
		trace("=======================");
		#end

		hotSpots.clear(); //Get rid of the old hotspots.

		var backDropName: String = "";
		
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
		
		for (hs in newScene.hotSpots)
		{
			if (hs.flagList.checkFlags())
			{
				hotSpots.add(hs);
			}
		}
		
		#if debug
		trace("Scene changed!");
		trace(newScene);
		trace(FlxG.levels[0].toString());
		#end
	}
	
	function setupItems()
	{
		items = new Hash<Item>();
		var itemList: Array<String> = ["Key", "Mask", "Thing", "TestItem1", "TestItem2", "TestItem3", "TestItem4", "TextItem5"];
		
		var itemX:Float = 1035;
		var itemY:Float = 45;
		
		for(item in itemList)
		{
			
			var tempItem = new Item(itemX, itemY, 95, 95, item);
			items.set(item, tempItem);
			itemGroup.add(tempItem);
			if (itemX == 1035)
			{
				itemX += 106;
			}
			else 
			{
				itemX = 1035;
				itemY += 110;

			}
		}
		
	}
}
