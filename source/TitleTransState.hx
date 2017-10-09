package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author ninjaMuffin
 */
class TitleTransState extends FlxState 
{
	private var _titleText:FlxText;
	
	private var _timer:Float = 4;
	
	override public function create():Void 
	{
		_titleText = new FlxText(0, 0, 0, "Part 2: Heist", 16);
		_titleText.screenCenter();
		add(_titleText);
		
		FlxG.camera.fade(FlxColor.BLACK, 0.6, true);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		_timer -= FlxG.elapsed;
		
		if (_timer <= 0)
		{
			FlxG.switchState(new HeistState());
		}
		
		super.update(elapsed);
	}
	
}