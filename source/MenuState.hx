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
		backDrop.makeGraphic(640, 480, 0xffff0000);
		backDrop.x = 0;
		backDrop.y = 0;
		backDrop.immovable = true;
		add(backDrop);
		
        var helloWorldText = new FlxText(0, 0, FlxG.width, "Hello World!", true);
		helloWorldText.setFormat(null, 16, 0xFFFFFF, "center");
		add(helloWorldText);
				
		var testButton = new FlxButton(FlxG.width / 2, FlxG.height / 2, "Start");
		// testButton.alpha = 0;
		// testButton.label.alpha = 0;

		var onOver = Assets.getSound("Beep");
		testButton.setSounds(onOver);
		testButton.onOver = function(){
				FlxG.mouse.show("assets/data/pointer-green.png");
			};	
		testButton.onOut = function() {
				FlxG.mouse.show("assets/data/pointer-yellow.png");
			};
		testButton.onDown = function() {
				FlxG.switchState(new PlayState());
				this.kill();
			};
		add(testButton);
		FlxG.mouse.show("assets/data/pointer-yellow.png");
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}	
}
