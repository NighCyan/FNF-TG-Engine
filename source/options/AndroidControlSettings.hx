package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import options.BaseOptionsMenu;
import options.Option;
import openfl.Lib;

using StringTools;

class AndroidControlSettings extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Hitbox Settings';
		rpcTitle = 'Hitbox Settings Menu'; //hi, you can ask what is that, i will answer it's all what you needed lol.

		var option:Option = new Option('Hitbox Mode:',
			"Choose your Hitbox Style!",
			'hitboxmode',
			'string',
			'Classic',
			['Classic', 'New']);
		  addOption(option);
		  
		var option:Option = new Option('Hitbox Opacity',
			'Changes opacity',
			'hitboxalpha',
			'float',
			0.2);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		var option:Option = new Option('Virtual pad Opacity',
			'Changes virtual pad opacity.', 'virtualPadAlpha', 'float',
			0.5);
		option.scrollSpeed = 1.6;
		option.minValue = 0;
		option.maxValue = 1;
		option.changeValue = 0.01;
		option.decimals = 2;
		addOption(option);
		
		var option:Option = new Option('Perpheral Mouse Allowed',
			'Use mouse replace touch when need', 'perpheralMouseAllowed', 'bool',
			false);
		addOption(option);

		super();
	}

/*
	override function update(elapsed:Float)
	{
		super.update(elapsed);
			#if android
		if (FlxG.android.justReleased.BACK)
		{
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new options.OptionsState());
	}
		#end
		}
	*/ //why this exists?!?¡
}