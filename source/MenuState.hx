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
	
	override public function create():Void
	{
		
		#if !neko
		FlxG.bgColor = 0xffffffff;
		#else
		FlxG.camera.bgColor = {rgb: 0xffffff, a: 0xff};
		#end		
		//FlxG.mouse.show();
		
		#if android
			FlxG.addSound("Beep");
		#end
		
		var backDrop = new FlxSprite();
		backDrop.makeGraphic(FlxG.width, FlxG.height, 0xff009D91);
		backDrop.x = 0;
		backDrop.y = 0;
		backDrop.immovable = true;
		add(backDrop);
		
        var titleText = new FlxText(0, FlxG.height / 10, FlxG.width, "Diorama Escape");
		titleText.setFormat(null, FlxG.height / 10, 0xFFFFFF, "center");
		
		var clickToContinueText = new FlxText(0, FlxG.height * 2 / 3, FlxG.width, "Click To Continue");
		clickToContinueText.setFormat(null, FlxG.height / 20, 0xFFFFA700, "center");
		
		add(titleText);
		add(clickToContinueText);
		
		FlxG.mouse.show("assets/data/pointer-yellow.png");
	}
	

	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		if(FlxG.mouse.justPressed())
		{
				FlxG.flash(0xFFFFFF, 0.75);
				FlxG.fade(0xFF000000, 1, onFade);
		}
	}	
	
	private function onFade ():Void
	{
			FlxG.switchState(new PlayState());
	}

}
