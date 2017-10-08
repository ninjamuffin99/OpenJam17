package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ninjaMuffin
 */
class Player extends FlxSprite 
{
	private var speed:Float = 100;
	private var runMulitplier:Float = 1.6;
	
	private var interacting:Bool = false;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y);
		makeGraphic(40, 80);
		acceleration.y = 800;
	}
	
	override public function update(elapsed:Float):Void 
	{
		controls();
		
		super.update(elapsed);
	}
	
	public function controls():Void
	{
		var _left:Bool = false;
		var _right:Bool = false;
		var _down:Bool = false;
		var _run:Bool  = false;
		
		_left = FlxG.keys.anyPressed([A, J, LEFT]);
		_right = FlxG.keys.anyPressed([D, L, RIGHT]);
		_down = FlxG.keys.anyPressed([S, K, DOWN]);
		_run = FlxG.keys.anyPressed([SHIFT]);
		
		if (_left && _right)
		{
			_left = _right = false;
		}
		
		if (_down)
		{
			speed = 50;
			makeGraphic(40, 40);
			height = 80;
			offset.y = -40;
		}
		else
		{
			speed = 100;
			makeGraphic(40, 80);
			offset.y = 0;
		}
		
		FlxG.watch.addQuick("Dragging", _down);
		FlxG.watch.addQuick("Drag", speed);
		
		if (_left || _right)
		{
			if (_left)
			{
				
				if (_run)
				{
					velocity.x = -speed * runMulitplier;
				}
				else
				{
					velocity.x = -speed;
				}
			}
			if (_right)
			{
				
				if (_run)
				{
					velocity.x = speed * runMulitplier;
				}
				else
				{
					velocity.x = speed;
				}
			}
		}
		else
		{
			velocity.x = 0;
		}
		
		
	}
	/**
	 * 
	 * @param	object
	 * Which object it needs to be overlapping.
	 * @param	_objAnimOnly
	 * If only the object will be animated (If false then sets the player to invisible)
	 * @param	_animationON
	 * What animation to play when interacting
	 * @param	_animationOFF
	 * what animation to play when not interacting
	 * @param	sound
	 * @param	collision
	 * if player collides with object
	 * @param	objectOffset
	 * @param	Callback
	 * @param	CallbackFunc
	 */
	
	public function interact(object:FlxSprite, _objAnimOnly:Bool,  _animationON:String = "", _animationOFF:String = "", sound:String = null, collision:Bool = false, objectOffset:Float = 0, Callback:Bool = false, CallbackFunc:Void->Void = null)
	{
		if (collision)
		{
			object.immovable = true;
			FlxG.collide(this, object);
		}
		
		var _btnInteract:Bool = false;
		_btnInteract = FlxG.keys.anyJustPressed([SPACE, W, E, I, O, UP]);
		
		var _btnUninteract:Bool = false;
		_btnUninteract = FlxG.keys.anyPressed([LEFT, A, J, RIGHT, D, L]);
		
		
		if (FlxG.overlap(this, object))
		{
			
			if (_btnInteract && !interacting)
			{
				
				object.animation.play(_animationON);
				FlxG.sound.play(sound);
				
				if (Callback)
				{
					CallbackFunc();
				}
				
				//change this so it calls a special function or something like sitdown if needed
				if (!_objAnimOnly)
				{
					visible = false;
					interacting = true;
				}
				//FlxG.sound.playMusic("assets/music/track1.mp3");
			}
			
			if (_btnUninteract && interacting)
			{
				object.animation.play(_animationOFF);
				interacting = false;
				visible = true;
			}
			
			if (interacting)
			{
				this.x = object.x + objectOffset;
			}
		}
		
	}
	
}