import StringTools;

var leftDude:FlxSprite;
var rightDude:FlxSprite;
var leftCooldown:Int = 40;
var rightCooldown:Int = 40;
var SMACCEMleft:Bool = false;
var SMACCEMright:Bool = false;

function postCreate() {
	for (i in 0...4) {
		cpuStrums.members[i].x -= 640;
		playerStrums.members[i].x += 640;
	}
	for (healthThing in [healthBar, healthBarBG, iconP1, iconP2, scoreTxt, missesTxt, accuracyTxt])
		healthThing.y += 300;

	leftDude = new FlxSprite(250, 200);
	leftDude.frames = Paths.getSparrowAtlas("stages/bar/bgGuys");
	leftDude.scrollFactor.set(0.95, 0.95);
	leftDude.antialiasing = true;
	leftDude.visible = false;
	leftDude.flipX = true;
	insert(members.indexOf(gf), leftDude);

	rightDude = new FlxSprite(700, 200);
	rightDude.frames = Paths.getSparrowAtlas("stages/bar/bgGuys");
	rightDude.scrollFactor.set(0.95, 0.95);
	rightDude.antialiasing = true;
	rightDude.visible = false;
	insert(members.indexOf(gf), rightDude);

	for (i in 0...8) {
		var animNames = ["idle0", "idle1", "idle2", "idle3", "oofOwieMyBones", "high", "low"];
		var animPrefixes = ["0", "1", "2", "3", "die", "jumpH", "jumpL"];
		leftDude.animation.addByPrefix(animNames[i], animPrefixes[i], 24, false);
		rightDude.animation.addByPrefix(animNames[i], animPrefixes[i], 24, false);
	}
}

function beatHit(curBeat:Int) {
	leftCooldown -= 1;
	rightCooldown -= 1;
	if (SMACCEMleft) {
		ded(leftDude, "swingLEFT");
		SMACCEMleft = false;
		leftCooldown = 10;
	}
	if (SMACCEMright) {
		ded(rightDude, "swingRIGHT");
		SMACCEMright = false;
		rightCooldown = 10;
	}

	if (leftCooldown <= 0 && FlxG.random.bool(5)) {
		ello(leftDude);
	}
	if (rightCooldown <= 0 && FlxG.random.bool(5)) {
		ello(rightDude);
	}

	if (curBeat > 16 && curBeat < 32 && curBeat % 2 == 0 && StringTools.startsWith(leftDude.animation.curAnim.name, "idle")) {
		leftDude.animation.play(leftDude.animation.curAnim.name, true);
		rightDude.animation.play(rightDude.animation.curAnim.name, true);
	}
}

function ello(dude:FlxSprite) {
	dude.visible = true;
	var isLeft = (dude == leftDude);
	var anims = ["low", "high"];
	var offsets = [
		{x: -150, y: -30},
		{x: -130, y: -20},
		{x: -130, y: -30},
		{x: -120, y: 30}
	];
	var leftOffsets = [90, 170, 190, 210];
	var multX:Int = 1 - (2 * isLeft);
	dude.animation.play(anims[FlxG.random.int(0, 1)], true);
	dude.animation.finishCallback = function(name) {
		var randomNum = FlxG.random.int(0, 3);
		dude.offset.set(offsets[randomNum].x * multX - (leftOffsets[randomNum] * isLeft), offsets[randomNum].y);
		dude.animation.play("idle" + randomNum, true);
		dude.animation.finishCallback = function(name) {
			if (isLeft && curBeat > 32)
				SMACCEMleft = true;
			else if (curBeat > 32)
				SMACCEMright = true;
		};
	};
}

function ded(dude:FlxSprite, swingAnim:String) {
	gf.playAnim(swingAnim, true);
	dude.animation.play("oofOwieMyBones", true);
	dude.offset.set(0, 0);
	dude.animation.finishCallback = function(name) {
		dude.visible = false;
	};
}

function stepHit() {
  switch (curStep) {
	case 64:
		gf.playAnim("handsUP", true);
		gf.script.set("onDance", function(event) {
			event.cancel();
		});
		FlxG.camera.zoom += 0.25;
		ello(leftDude);
		ello(rightDude);
	case 96:
		gf.playAnim("getBat", true);
	case 120:
		ded(leftDude, "swingLEFT");
	case 128:
		ded(rightDude, "swingRIGHT");
		for (i in 0...4)
			FlxTween.tween(cpuStrums.members[i], {x: cpuStrums.members[i].x + 640}, Conductor.crochet / 500, {ease: FlxEase.circOut});
		var ogAnimFinish = gf.animation.finishCallback;
		gf.animation.finishCallback = function(name) {
			gf.script.set("onDance", function(event) {
				event.cancel();
				var danceAnim = (gf.danced = !gf.danced) ? "danceLeft-bat" : "danceRight-bat";
				gf.playAnim(danceAnim, true, "DANCE");
			});
			gf.animation.finishCallback = ogAnimFinish;
		}
	case 184:
		for (i in 0...4)
			FlxTween.tween(playerStrums.members[i], {x: playerStrums.members[i].x - 640}, Conductor.crochet / 500, {ease: FlxEase.circOut});

		for (healthThing in [healthBar, healthBarBG, iconP1, iconP2, scoreTxt, missesTxt, accuracyTxt])
			FlxTween.tween(healthThing, {y: healthThing.y - 300}, Conductor.crochet / 500, {ease: FlxEase.circOut});
  }
}