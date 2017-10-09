package;

import flixel.FlxG;
import flixel.FlxObject;
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

	
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	
	override public function create():Void 
	{
		_map = new FlxOgmoLoader(AssetPaths.Heist__oel);
		_mWalls = _map.loadTilemap(AssetPaths.Tile__0001__png, 16, 16, "walls");
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.ANY);
		add(_mWalls);
		
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
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		FlxG.collide(_player, _mWalls);
	}
}