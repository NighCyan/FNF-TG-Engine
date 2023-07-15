package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	private var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	var isTransIn:Bool = false;
	
	var loadLeft:FlxSprite;
	var loadRight:FlxSprite;
	
	var loadLeftTween:FlxTween;
	var loadRightTween:FlxTween;
	var loadTextTween:FlxTween;
	
	var tipsShit:Array<String> = CoolUtil.coolTextFile(SUtil.getPath() + Paths.txt('loadingTipsList'));

	public function new(duration:Float, isTransIn:Bool) {
		super();

		this.isTransIn = isTransIn;
		tipsShit.push('Engine made by TieGuo');
		
		loadLeft = new FlxSprite(isTransIn ? 0 : -1280, 0).loadGraphic(Paths.image('loadingL'));
		loadLeft.scrollFactor.set();
		add(loadLeft);
		
		loadRight = new FlxSprite(isTransIn ? 0 : 1280, 0).loadGraphic(Paths.image('loadingR'));
		loadRight.scrollFactor.set();
		add(loadRight);

		if(!isTransIn) {
			FlxG.sound.play(Paths.sound('shutter_close'));
			
			var tipShit:FlxText = new FlxText(isTransIn ? 50 : -1230, FlxG.height - 200, 0, tipsShit[FlxG.random.int(0, tipsShit.length-1)], 30);
			tipShit.scrollFactor.set();
			tipShit.setFormat(Paths.font('syht.ttf'), 30, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			add(tipShit);
		
			loadLeftTween = FlxTween.tween(loadLeft, {x: 0}, duration, {
				onComplete: function(twn:FlxTween) {
					if(finishCallback != null) {
						finishCallback();
					}
				},
			ease: FlxEase.quartInOut});
			
			loadRightTween = FlxTween.tween(loadRight, {x: 0}, duration, {
				onComplete: function(twn:FlxTween) {
					if(finishCallback != null) {
						finishCallback();
					}
				},
			ease: FlxEase.quartInOut});
			
			loadTextTween = FlxTween.tween(tipShit, {x: 50}, duration, {
				onComplete: function(twn:FlxTween) {
					if(finishCallback != null) {
						finishCallback();
					}
				},
			ease: FlxEase.quartInOut});
		} else {
			FlxG.sound.play(Paths.sound('shutter_open'));
			loadLeftTween = FlxTween.tween(loadLeft, {x: -1280}, duration, {
				onComplete: function(twn:FlxTween) {
					close();
				},
			ease: FlxEase.smootherStepIn});
			
			loadRightTween = FlxTween.tween(loadRight, {x: 1280}, duration, {
				onComplete: function(twn:FlxTween) {
					close();
				},
			ease: FlxEase.smootherStepIn});
			
			loadTextTween = FlxTween.tween(tipShit, {x: -1230}, duration, {
				onComplete: function(twn:FlxTween) {
					close();
				},
			ease: FlxEase.smootherStepIn});
		}

		if(nextCamera != null) {
			loadRight.cameras = [nextCamera];
			loadLeft.cameras = [nextCamera];
		}
		nextCamera = null;
	}

	override function destroy() {
		if(leTween != null) {
			finishCallback();
			leTween.cancel();
			loadLeftTween.cancel();
			loadRightTween.cancel();
		}
		super.destroy();
	}
}