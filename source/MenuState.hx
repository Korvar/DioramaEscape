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
	var flagHash:Hash<Bool>;
	
	override public function create():Void
	{
		flagHash = new Hash<Bool>();
		flagHash.set("Testkey", false);
		flagHash.set("SamuraiCrest", true);
		flagHash.set("YagyuEyepatch", true);
		
		var testHash1 = new Hash<Bool>();
		testHash1.set("YagyuEyepatch", true);
		testHash1.set("SamuraiCrest", true);
		
		var testHash2 = new Hash<Bool>();
		testHash2.set("YagyuEyepatch", false);
		
		var testHash3 = new Hash<Bool>();
		testHash3.set("MadeUpKey", true);
		
		#if debug
		trace(flagHash.toString());
		trace(flagHash.get("FakeKey"));
		
		trace(checkFlags(testHash1));
		trace(checkFlags(testHash2));
		trace(checkFlags(testHash3));
		
		#end
		
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		FlxG.mouse.show();
		
		#if android
			FlxG.addSound("Beep");
		#end
		
		var backDrop = new FlxSprite();
		backDrop.loadGraphic("assets/data/SamuraiWideAngle.jpg", false, false, 640, 480);
		backDrop.x = 0;
		backDrop.y = 0;
		backDrop.immovable = true;
		add(backDrop);
		
		
        var helloWorldText = new FlxText(0, 0, FlxG.width, "Hello World!", true);
		helloWorldText.setFormat(null, 16, 0xFFFFFF, "center");
		add(helloWorldText);
				
		var testButton = new FlxButton(FlxG.width / 2, FlxG.height / 2, "");
		testButton.alpha = 0;
		testButton.label.alpha = 0;
		add(testButton);
		var onOver = Assets.getSound("Beep");
		testButton.setSounds(onOver);
		
		
				
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
