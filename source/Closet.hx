package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.util.FlxColor;

/**
 * ...
 * @author ninjaMuffin
 */
class Closet extends FlxSubState 
{

	private var _screwDriver:FlxSprite;
	
	override public function create():Void 
	{
		FlxG.plugins.add(new FlxMouseEventManager());
		
		_screwDriver = new FlxSprite(20, 30);
		_screwDriver.makeGraphic(200, 200);
		add(_screwDriver);
		
		FlxMouseEventManager.add(_screwDriver, recolor);
		
		super.create();
	}
	
	private function recolor(_):Void
	{
		close();
	}
}