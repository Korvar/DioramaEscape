package;

import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSound;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;

class MenuState extends FlxState
{
	var flagHash:FlagList;
	
	override public function create():Void
	{
		flagHash = new FlagList();
		flagHash.set("Testkey", false);
		flagHash.set("SamuraiCrest", true);
		flagHash.set("YagyuEyepatch", true);
		FlxG.levels[0] = flagHash;
		
		var testHash1 = new FlagList();
		testHash1.set("YagyuEyepatch", true);
		testHash1.set("SamuraiCrest", true);
		
		var testHash2 = new FlagList();
		testHash2.set("YagyuEyepatch", false);
		
		var testHash3 = new FlagList();
		testHash3.set("MadeUpKey", true);
		
		FlxG.levels[1] = new Hash<Scene>();
		
		#if debug
		trace(FlxG.levels[0].toString());
		trace(FlxG.levels[0].get("FakeKey"));
		
		trace(checkFlags(testHash1) + " " + testHash1.checkFlags());
		trace(checkFlags(testHash2) + " " + testHash2.checkFlags());
		trace(checkFlags(testHash3) + " " + testHash3.checkFlags());
		testHash3.setFlags();
		trace(FlxG.levels[0].toString());
		#end
		

		
		
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		//FlxG.mouse.show();
		
		#if android
			FlxG.addSound("Beep");
		#end
		
		var backDrop = new FlxSprite();
		backDrop.loadGraphic("assets/data/SamuraiWideAngle.jpg", false, false, 640, 480);
		backDrop.x = 0;
		backDrop.y = 0;
		backDrop.immovable = true;
		add(backDrop);
		
		var mouseImage = new FlxSprite();
		mouseImage.loadGraphic("assets/data/pointers.png", true, false, 64, 64);
		mouseImage.addAnimation("Green", [0]);
		mouseImage.addAnimation("Yellow", [2]);
		mouseImage.play("Yellow");
		//FlxG.mouse.load(mouseImage);
		FlxG.mouse.show("assets/data/pointer-yellow.png");

		
		
        var helloWorldText = new FlxText(0, 0, FlxG.width, "Hello World!", true);
		helloWorldText.setFormat(null, 16, 0xFFFFFF, "center");
		add(helloWorldText);
				
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
	}	
	
	function checkFlags(flagList:Hash<Bool>):Bool
	{
		for (key in flagList.keys())
		{
			if (flagHash.get(key) != flagList.get(key))
			{
				return false;
			}
		}
		return true;
	}
}
