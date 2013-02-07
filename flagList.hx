package ;

/**
 * ...
 * @author Mike Cugley
 */

 import org.flixel.FlxG;
 
class FlagList extends Hash<Bool>
{

	public function new() 
	{
		super();  // Not actually adding anything to the creation process
	}
	
	public function checkFlags()
	{
		for (key in this.keys())
		{
			if (this.get(key) != FlxG.levels[0].get(key))
			{
				return false;
			}
		}
		return true;
	}
	
	public function setFlags()
	{
		for (key in this.keys())
		{
			FlxG.levels[0].set(key, this.get(key));
		}
	}
	
	
}