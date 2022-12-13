import StringTools;

var normOnDance;
var normAnimFinish;
var leftDude:FlxSprite;
var rightDude:FlxSprite;
var leftCooldown:Int = 32;
var rightCooldown:Int = 32;
var SMACCEMleft:Int = 30;
var SMACCEMright:Int = 30;

function postCreate() {
	for (i in 0...4) {
		cpuStrums.members[i].x -= 640;
		playerStrums.members[i].x += 640;
	}
	for (healthThing in [healthBar, healthBarBG, iconP1, iconP2, scoreTxt, missesTxt, accuracyTxt])
		healthThing.y += 300;

	normOnDance = gf.script.get("onDance");

	leftDude = new FlxSprite(250, 200);
	leftDude.flipX = true;
	leftDude.frames = Paths.getSparrowAtlas("stages/bar/bgGuys");
	leftDude.antialiasing = true;
	leftDude.visible = false;
	insert(members.indexOf(gf), leftDude);

	rightDude = new FlxSprite(700, 200);
	rightDude.frames = Paths.getSparrowAtlas("stages/bar/bgGuys");
	rightDude.antialiasing = true;
	rightDude.visible = false;
	insert(members.indexOf(gf), rightDude);

	normAnimFinish = rightDude.animation.finishCallback;

	for (i in 0...8) {
		var animNames = ["idle0", "idle1", "idle2", "idle3", "oofOwieMyBones", "high", "low"];
		var animPrefixes = ["0", "1", "2", "3", "die", "jumpH", "jumpL"];
		leftDude.animation.addByPrefix(animNames[i], animPrefixes[i], 24, false);
		rightDude.animation.addByPrefix(animNames[i], animPrefixes[i], 24, false);
	}
}

function postUpdate() {
	if (leftDude.animation.curAnim == null) return;
	
	leftDude.offset.x = 50 * StringTools.startsWith(leftDude.animation.curAnim.name, "idle");
	rightDude.offset.x = -30 * StringTools.startsWith(rightDude.animation.curAnim.name, "idle");

	if (StringTools.startsWith(leftDude.animation.curAnim.name, "idle"))
		leftDude.animation.curAnim.curFrame = leftDude.animation.curAnim.curFrame * (leftDude.animation.curAnim.curFrame < 15) + 14 * (leftDude.animation.curAnim.curFrame >= 15);
	if (StringTools.startsWith(rightDude.animation.curAnim.name, "idle"))
		rightDude.animation.curAnim.curFrame = rightDude.animation.curAnim.curFrame * (rightDude.animation.curAnim.curFrame < 15) + 14 * (rightDude.animation.curAnim.curFrame >= 15);
}

function beatHit(curBeat:Int) {
	leftCooldown -= 1;
	rightCooldown -= 1;
	SMACCEMleft -= 1 * (leftDude.visible && curBeat > 32);
	SMACCEMright -= 1 * (rightDude.visible && curBeat > 32);
	/*if (SMACCEMleft <= 0) {
		ded(leftDude, "swingLEFT");
		SMACCEMleft = 30;
		leftCooldown = 10;
	}
	if (SMACCEMright <= 0) {
		ded(rightDude, "swingRIGHT");
		SMACCEMright = 30;
		rightCooldown = 10;
	}*/

	if (leftCooldown <= 0 && FlxG.random.bool(5)) {
		ello(leftDude);
		leftDude.animation.finishCallback = function(name) {
			SMACCEMleft = 2;
		};
	}
	if (rightCooldown <= 0 && FlxG.random.bool(5)) {
		ello(rightDude);
		SMACCEMright = true;
		rightDude.animation.finishCallback = function(name) {
			SMACCEMright = 2;
		};
	}

	if (curBeat > 16 && curBeat < 32 && curBeat % 2 == 0 && StringTools.startsWith(leftDude.animation.curAnim.name, "idle")) {
		leftDude.animation.play(leftDude.animation.curAnim.name, true);
		rightDude.animation.play(rightDude.animation.curAnim.name, true);
	}
}

function ello(dude:FlxSprite) {
	dude.visible = true;
	dude.animation.play("low", true);
	dude.animation.finishCallback = function(name) {
		dude.animation.play("high", true);
		dude.animation.finishCallback = function(name) {
			dude.animation.play("idle" + FlxG.random.int(0, 3), true);
		};
	};
}

function ded(dude:FlxSprite, swingAnim:String) {
	gf.playAnim(swingAnim, true);
	dude.animation.play("oofOwieMyBones", true);
	dude.animation.finishCallback = function(name) {
		dude.visible = false;
		dude.animation.finishCallback = normAnimFinish;
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
	case 129:
		gf.script.set("onDance", normOnDance);
	case 184:
		for (i in 0...4)
			FlxTween.tween(playerStrums.members[i], {x: playerStrums.members[i].x - 640}, Conductor.crochet / 500, {ease: FlxEase.circOut});

		for (healthThing in [healthBar, healthBarBG, iconP1, iconP2, scoreTxt, missesTxt, accuracyTxt])
			FlxTween.tween(healthThing, {y: healthThing.y - 300}, Conductor.crochet / 500, {ease: FlxEase.circOut});
  }
}