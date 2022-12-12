import funkin.scripting.events.NoteHitEvent;
import funkin.ui.FunkinText;
import funkin.game.HealthIcon;

var spoopyShader:FunkinShader = new FunkinShader("
#pragma header

uniform float multX = 0.0;
uniform float multY = 0.0;
uniform bool goSpoopy = false;

void main() {
	vec2 pos = openfl_TextureCoordv;
	if (goSpoopy) {
		pos.x += 3 / openfl_TextureSize.x * multX;
		pos.y += 3 / openfl_TextureSize.y * multY;
	}
	vec4 overlay = texture2D(bitmap, pos);
	vec4 normColor = texture2D(bitmap, openfl_TextureCoordv);
	if (goSpoopy) {
		overlay.g = 0;
		overlay.b *= 0.25;
		overlay *= 0.5;

		normColor.g = 0;
		normColor.b *= 0.25;
		normColor *= 0.5;
		normColor = mix(normColor, overlay, overlay.a);
	}
	gl_FragColor = normColor;
}
");
var shaderPosArray = [
	{x: -1, y: -1},
	{x: -0.5, y: -1},

	{x: 0, y: -1},
	{x: 0.5, y: -1},

	{x: 1, y: -1},
	{x: 1, y: -0.5},

	{x: 1, y: 0},
	{x: 1, y: 0.5},

	{x: 1, y: 1},
	{x: 0.5, y: 1},

	{x: 0, y: 1},
	{x: -0.5, y: 1},

	{x: -1, y: 1},
	{x: -1, y: 0.5},

	{x: -1, y: 0},
	{x: -1, y: -0.5},
];
var spoopyBois:Character;
var darken:FlxSprite;
var subtitles:FunkinText;
var spoopyboiziconzcweil:HealthIcon;

function postCreate() {
	spoopyBois = new Character(100, 100, "spooky-bside");
	insert(members.indexOf(dad), spoopyBois);
	dad.visible = false;
	iconP2.visible = false;
	spoopyboiziconzcweil = new HealthIcon("spooky-bside", false);
	spoopyboiziconzcweil.cameras = [camHUD];
	add(spoopyboiziconzcweil);


	subtitles = new FunkinText(0, 480, 1280, "", 24);
	subtitles.shader = spoopyShader;
	spoopyShader.data.goSpoopy.value = [false];
	subtitles.alignment = "center";
	subtitles.cameras = [camHUD];
	add(subtitles);
}

function onCountdown()
	spoopyBois.dance();

function postUpdate() {
	var eighthStep:Int = Math.floor((curStepFloat % 2) / 0.125);
	var shaderPos = shaderPosArray[eighthStep];
	spoopyShader.data.multX.value = [shaderPos.x];
	spoopyShader.data.multY.value = [shaderPos.y];

	spoopyboiziconzcweil.y = iconP2.y;
	spoopyboiziconzcweil.x = iconP2.x;
	spoopyboiziconzcweil.scale = iconP2.scale;
	spoopyboiziconzcweil.health = iconP2.health;
	spoopyboiziconzcweil.updateHitbox();
}

function onCameraMove(event)
	event.position.y += 350 * (curStep < 248 && !curSection.mustHitSection);

function onDadHit(event:NoteHitEvent) {
	if (curStep < 248)
		event.character = spoopyBois;
}

function spoopySubtitles(spoopy:Bool) {
	subtitles.color = 0xFFFFFFFF - 0xFF00FFB0 * spoopy;
	var daScale = 1 + 0.5 * spoopy;
	subtitles.scale.set(daScale, daScale);
	spoopyShader.data.goSpoopy.value = [spoopy];
}

function onSubStateOpen() {
	if (deleteTimer != null)
		deleteTimer.active = false;
}

function onSubStateClose() {
	if (deleteTimer != null)
		deleteTimer.active = true;
}

var deleteTimer:FlxTimer;
function stepHit(curStep:Int) {
  switch (curStep) {
	case 248:
		darken = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF000000);
		darken.scale.set(2, 2);
		darken.cameras = [camHUD];
		add(darken);

		spoopyBois.visible = false;
		spoopyboiziconzcweil.visible = false;
		iconP2.visible = true;
		dad.visible = true;

		health = 0.05;
		healthBar.alpha = 0.25;
		healthBarBG.alpha = 0.5;
		accuracyTxt.alpha = 0.25;
		missesTxt.alpha = 0.25;
		scoreTxt.alpha = 0.25;
		for (i in 0...4) {
			cpuStrums.members[i].x -= 2000;
			playerStrums.members[i].x -= 320;
		}
		//Using a timer because you can't trust lag.
		deleteTimer = new FlxTimer().start(Conductor.crochet / 500, function(tmr:FlxTimer) {
			remove(darken);
			darken.destroy();
			darken = null;
			subtitles.text = "What have you brought me?";
			deleteTimer = null;
		});

		ohNoSpoopyTime();
	case 271:
		subtitles.text = "Who's the new specimen?";
	case 290:
		subtitles.text = "Will he comply,";
	case 299:
		subtitles.text = "or has ego got the best of him?";
	case 385:
		subtitles.text = "No need to struggle.";
	case 398:
		subtitles.text = "Hush now, it'll be over soon.";
	case 417:
		subtitles.text = "No one to save you.";
	case 430:
		subtitles.text = "No way out inside your view.";
	case 512:
		subtitles.text = "Cut him up, and then melt him down.";
	case 576:
		spoopySubtitles(true);
		subtitles.text = "BOILING VEINS.";
	case 588:
		subtitles.text = "AH AH, NOT A SOUND.";
	case 640:
		spoopySubtitles(false);
		subtitles.text = "Look how you talk";
	case 651:
		subtitles.text = "with that shiver rolling down your spine.";
	case 673:
		subtitles.text = "Start breaking down";
	case 684:
		subtitles.text = "when";
	case 686:
		subtitles.text = "faced with imminent demise.";
	case 770:
		subtitles.text = "No need to struggle.";
	case 782:
		subtitles.text = "Hush now, it'll be over soon.";
	case 802:
		subtitles.text = "No one to save you.";
	case 814:
		subtitles.text = "No way out inside your view.";
	case 896:
		subtitles.text = "Blood runs cold and you freeze in place.";
	case 960:
		spoopySubtitles(true);
		subtitles.text = "RESISTING FATE?";
	case 972:
		subtitles.text = "YOU ARE A DISGRACE.";
	case 1024:
		spoopySubtitles(false);
		subtitles.text = "Nightmare consumes and turns you to not.";
	case 1088:
		spoopySubtitles(true);
		subtitles.text = "CAPTURE YOUR SOUL";
	case 1100:
		subtitles.text = "AND LEAVE YOU TO ROT.";
	case 1152:
		spoopySubtitles(false);
		subtitles.text = "Look how you talk";
	case 1162:
		subtitles.text = "with that shiver rolling down your spine.";
	case 1184:
		subtitles.text = "Start breaking down";
	case 1194:
		subtitles.text = "when";
	case 1198:
		subtitles.text = "faced with imminent demise.";
	case 1280:
		subtitles.text = "No need to struggle.";
	case 1294:
		subtitles.text = "Hush now, it'll be over soon.";
	case 1312:
		subtitles.text = "No one to save you.";
	case 1326:
		subtitles.text = "No way out inside your view.";
	case 1408:
		camHUD.flash(0xFFFF0040, 0.5);
		defaultCamZoom += 0.3;
		dad.visible = false;
		iconP2.visible = false;
		health = 0.05;
		accuracyTxt.alpha = 0;
		missesTxt.alpha = 0;
		scoreTxt.alpha = 0;
	case 1536:
		darken = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF000000);
		darken.scale.set(2, 2);
		darken.cameras = [camHUD];
		add(darken);
  }
}

function onPlayerHit()
	subtitles.text = "";
