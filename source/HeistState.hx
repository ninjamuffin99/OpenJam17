package;

import flixel.FlxState;

/**
 * ...
 * @author ninjaMuffin
 */
class HeistState extends FlxState 
{
	
	private var _player:Player;

	override public function create():Void 
	{
		_player = new Player()
		add(_player);
		
		super.create();
	}
}