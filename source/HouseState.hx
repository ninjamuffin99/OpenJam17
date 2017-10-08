package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class HouseState extends FlxState
{
	private var _player:Player;
	private var _bg:FlxSprite;
	
	
	private var _evidence:Evidence;
	private var _exit:FlxSprite;
	
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	
	
	private var _hasEvidence:Bool = false;
	
	private var _stairGround:FlxSprite;
	private var _stairSecond:FlxSprite;
	
	
	override public function create():Void
	{
		_map = new FlxOgmoLoader(AssetPaths.Debug__oel);
		_mWalls = _map.loadTilemap(AssetPaths.Tile__0001__png, 16, 16, "walls");
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.ANY);
		add(_mWalls);
		
		_bg = new FlxSprite(0, 0);
		_bg.loadGraphic(AssetPaths.House__0001__png, false, 900, 480);
		add(_bg);
		
		_evidence = new Evidence();
		add(_evidence);
		
		_stairGround = new FlxSprite();
		_stairGround.makeGraphic(16, 16);
		add(_stairGround);
		
		_stairSecond = new FlxSprite();
		_stairSecond.makeGraphic(16, 16);
		add(_stairSecond);
		
		_exit = new FlxSprite();
		_exit.makeGraphic(1, 1);
		add(_exit);
		
		_player = new Player();
		_map.loadEntities(placeEntities, "entities");
		add(_player);
		
		FlxG.camera.follow(_player);
		FlxG.camera.zoom = 2;
		
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
		
		if (entityName == "hosueBG")
		{
			_bg.x = x;
			_bg.y = y;
		}
		
		if (entityName == "Evidence")
		{
			_evidence.x = x;
			_evidence.y = y;
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
		
		if (entityName == "Exit")
		{
			_exit.x = x;
			_exit.y = y;
		}
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(_player, _mWalls);
		
		_player.interact(_evidence, true, "", "", null, false, 0, true, gather);
		
		_player.interact(_stairSecond, true, "", "", null, false, 0, true, moveToGround);
		_player.interact(_stairGround, true, "", "", null, false, 0, true, moveToSecond);
		
		_player.interact(_exit, true, "", "", null, false, 0, true, exitHouse);
		
	}
	
	public function gather():Void
	{
		_evidence.kill();
		_hasEvidence = true;
	}
	
	public function moveToGround():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
		{
			_player.setPosition(_stairGround.x, _stairGround.y);
			finishFade();
		});
	}
	
	public function moveToSecond():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
		{
			_player.setPosition(_stairSecond.x, _stairSecond.y);
			finishFade();
		});
	}
	
	public function exitHouse():Void
	{
		if (_hasEvidence)
		{
			FlxG.camera.fade();
		}
	}
	
	private function finishFade():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
	}
}