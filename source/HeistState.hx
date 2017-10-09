package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author ninjaMuffin
 */
class HeistState extends FlxState 
{
	
	private var _player:Player;
	private var _bg:FlxSprite;
	
	
	private var _stairGround:FlxSprite;
	private var _stairSecond:FlxSprite;
	
	private var _stairUpRight:FlxSprite;
	private var _stairDownRight:FlxSprite;

	
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	
	override public function create():Void 
	{
		_map = new FlxOgmoLoader(AssetPaths.Heist__oel);
		_mWalls = _map.loadTilemap(AssetPaths.Tile__0001__png, 16, 16, "walls");
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.ANY);
		add(_mWalls);
		
		_bg = new FlxSprite();
		_bg.loadGraphic(AssetPaths.Heist__0001__png, false, 2000, 480);
		add(_bg);
		
		_stairGround = new FlxSprite();
		_stairGround.makeGraphic(16, 16);
		add(_stairGround);
		
		_stairSecond = new FlxSprite();
		_stairSecond.makeGraphic(16, 16);
		add(_stairSecond);
		
		_stairUpRight = new FlxSprite();
		_stairUpRight.makeGraphic(16, 16);
		add(_stairUpRight);
		
		_stairDownRight = new FlxSprite();
		_stairDownRight.makeGraphic(16, 16);
		add(_stairDownRight);
		
		
		_player = new Player();
		add(_player);
		
		_map.loadEntities(placeEntities, "entities");
		
		FlxG.camera.follow(_player);
		FlxG.camera.zoom = 1.6;
		
		super.create();
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		
		if (entityName == "player")
		{
			_player.x = x;
			_player.y = y;
		}
		
		if (entityName == "StairGround")
		{
			_stairGround.x = x;
			_stairGround.y = y;
		}
		
		if (entityName == "StairSecond")
		{
			_stairSecond.x = x;
			_stairSecond.y = y;
		}
		
		if (entityName == "StairUpRight")
		{
			_stairUpRight.x = x;
			_stairUpRight.y = y;
		}
		
		if (entityName == "StairDownRight")
		{
			_stairDownRight.x = x;
			_stairDownRight.y = y;
		}
		
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		FlxG.collide(_player, _mWalls);
		
		_player.interact(_stairGround, true, "", "", null, false, 0, true, moveSecondLeft);
		_player.interact(_stairSecond, true, "", "", null, false, 0, true, moveGroundLeft);
		
		_player.interact(_stairDownRight, true, "", "", null, false, 0, true, moveSecondRight);
		_player.interact(_stairUpRight, true, "", "", null, false, 0, true, moveGroundRight);
		
	}
	
	private function moveSecondLeft():Void
	{
		_player.setPosition(_stairSecond.x, _stairSecond.y);
		FlxG.log.add("Move Second left");
	}
	
	private function moveGroundLeft():Void
	{
		_player.setPosition(_stairGround.x, _stairGround.y);
		FlxG.log.add("Move Ground Left");
	}
	
	private function moveSecondRight():Void
	{
		_player.setPosition(_stairUpRight.x, _stairUpRight.y);
		FlxG.log.add("Move Second Right");
	}
	
	private function moveGroundRight():Void
	{
		_player.setPosition(_stairDownRight.x, _stairDownRight.y);
		FlxG.log.add("Move Ground Right");
	}
	
}