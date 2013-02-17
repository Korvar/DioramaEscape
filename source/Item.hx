package ;

/**
 * ...
 * @author Mike Cugley
 */

 
import org.flixel.FlxButton;
import org.flixel.FlxSound;
import org.flixel.FlxG;
 
class Item extends HotSpot
{
	var inUse: Bool;
	var itemFlagList:FlagList;
	var itemSetFlagList:FlagList;
	var itemUnSetFlagList:FlagList;

	public function new(X:Float, Y:Float, Width:Float, Height:Float, ItemName:String) 
	{
		itemFlagList = new FlagList();
		itemSetFlagList = new FlagList();
		itemUnSetFlagList = new FlagList();
		
		itemFlagList.set(ItemName + "Got", true);
		itemSetFlagList.set(ItemName + "Used", true);
		itemUnSetFlagList.set(ItemName + "Used", false);

		
		super(X, Y, Width, Height, itemFlagList, itemSetFlagList, "", ItemName + "Detail", null);
		alpha = 1;  // Items, unlike hotspots, are visible
		inUse = false;
		

		
		makeGraphic(95, 95);
		
		onDown = function() {
			FlxG.mouse.show("assets/data/pointer-yellow.png");
			flagSetList.setFlags();
			
			if (inUse == false)
			{
				inUse == true;
				// Somehow set inUse to all the other items to false.
				// Do it in PlayState
			}
			else 
			{
				inUse == false;
				itemUnSetFlagList.setFlags();

			}
		};
	}
}