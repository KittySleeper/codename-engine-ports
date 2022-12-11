//PUT THIS IN "assets/data/states"! THIS IS THE OFFSET EDITOR STATE!

import funkin.game.HudCamera;
import funkin.game.Character;
import funkin.game.PlayState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.text.FlxText;

//The biggest yoink of Codename so far lol. -Srt

var init:Bool = false;

var gridBG:FlxSprite;
var char:Character;
var ghostChar:Character;
var danceAnim:String = "idle";
var textAnim:FlxText;
var dumbTexts:FlxText;
var animList:Array<String> = [];
var curAnim:Int = 0;
var daAnim:String = 'spooky';
var camFollow:FlxObject;

function postCreate()
{
    init = true;

	if (FlxG.sound.music != null)
		FlxG.sound.music.stop();

	gridBG = FlxGridOverlay.create(50, 50);
	gridBG.scrollFactor.set(0, 0);
    gridBG.color = 0xFF3B3B3B;
	add(gridBG);

	ghostChar = new Character(0, 0, daAnim);
	ghostChar.debugMode = true;
    ghostChar.alpha = 0.5;
	add(ghostChar);

    if (ghostChar.isDanceLeftDanceRight)
        danceAnim = "danceLeft";

    char = new Character(0, 0, daAnim);
	char.debugMode = true;
	add(char);

    var hud = new HudCamera();
    hud.bgColor = 0; // transparent
    FlxG.cameras.add(hud, false);

	dumbTexts = new FlxText(10, 20, 0, "", 15);
    dumbTexts.scrollFactor.set();
    dumbTexts.cameras = [hud];
	add(dumbTexts);

	textAnim = new FlxText(300, 16);
	textAnim.scrollFactor.set();
    textAnim.cameras = [hud];
    textAnim.size = 26;
	add(textAnim);

	genBoyOffsets(true);

	camFollow = new FlxObject(0, 0, 2, 2);
	camFollow.screenCenter();
	add(camFollow);

	FlxG.camera.follow(camFollow);
}

function genBoyOffsets(pushList:Bool = true):Void
{
	var daLoop:Int = 0;

	for (anim in char.animOffsets.keys())
	{
        var offsets = char.animOffsets[anim];
		dumbTexts.text += anim + ": " + offsets + "\n";

		if (pushList)
			animList.push(anim);

		daLoop++;
	}
}

function updateTexts():Void
{
	dumbTexts.text = "";
}

function update(elapsed:Float)
{
    if (!init) return;
	textAnim.text = char.animation.curAnim.name;

    if (FlxG.keys.justPressed.E || FlxG.keys.justPressed.Q) {
        FlxG.camera.zoom += 0.25 - 0.5 * (FlxG.keys.justPressed.Q);
        if (FlxG.camera.zoom <= 0)
            FlxG.camera.zoom = 0.25;

        var zoomScale:Float = 1 / FlxG.camera.zoom;
        gridBG.scale.set(zoomScale, zoomScale);
    }

	if (FlxG.keys.pressed.I || FlxG.keys.pressed.J || FlxG.keys.pressed.K || FlxG.keys.pressed.L)
	{
		if (FlxG.keys.pressed.I)
			camFollow.velocity.y = -90;
		else if (FlxG.keys.pressed.K)
			camFollow.velocity.y = 90;
		else
			camFollow.velocity.y = 0;

		if (FlxG.keys.pressed.J)
			camFollow.velocity.x = -90;
		else if (FlxG.keys.pressed.L)
			camFollow.velocity.x = 90;
		else
			camFollow.velocity.x = 0;
	}
	else
	{
		camFollow.velocity.set();
	}

	if (FlxG.keys.justPressed.W)
	{
		curAnim -= 1;
	}

	if (FlxG.keys.justPressed.S)
	{
		curAnim += 1;
	}

	if (curAnim < 0)
		curAnim = animList.length - 1;

	if (curAnim >= animList.length)
		curAnim = 0;

	if (FlxG.keys.justPressed.S || FlxG.keys.justPressed.W || FlxG.keys.justPressed.SPACE)
	{
		char.playAnim(animList[curAnim], true);
        ghostChar.playAnim(danceAnim, true);

		updateTexts();
		genBoyOffsets(false);
	}

	var upP = FlxG.keys.justPressed.UP;
	var rightP = FlxG.keys.justPressed.RIGHT;
	var downP = FlxG.keys.justPressed.DOWN;
	var leftP = FlxG.keys.justPressed.LEFT;

	var holdShift = FlxG.keys.pressed.SHIFT;
	var multiplier = 1;
	if (holdShift)
		multiplier = 10;

	if (upP || rightP || downP || leftP)
	{
		updateTexts();
		if (upP)
			char.animOffsets[animList[curAnim]].y += 1 * multiplier;
		if (downP)
			char.animOffsets[animList[curAnim]].y -= 1 * multiplier;
		if (leftP)
			char.animOffsets[animList[curAnim]].x += 1 * multiplier;
		if (rightP)
			char.animOffsets[animList[curAnim]].x -= 1 * multiplier;

        ghostChar.animOffsets[danceAnim].set(char.animOffsets[danceAnim].x, char.animOffsets[danceAnim].y);
		updateTexts();
		genBoyOffsets(false);
		char.playAnim(animList[curAnim], true);
        ghostChar.playAnim(danceAnim, true);
	}

    if (FlxG.keys.justPressed.ESCAPE)
        FlxG.switchState(new PlayState());
}