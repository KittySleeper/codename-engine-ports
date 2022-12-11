import funkin.scripting.events.NoteHitEvent;
import funkin.ui.FunkinText;

var spoopyBois:Character;
var darken:FlxSprite;
var subtitles:FunkinText;

function postCreate() {
	spoopyBois = new Character(100, 100, "spooky-bside");
	insert(members.indexOf(dad), spoopyBois);
	dad.visible = false;

	subtitles = new FunkinText(0, 480, 1280, "", 24);
	subtitles.alignment = "center";
	subtitles.cameras = [camHUD];
	add(subtitles);
}

function onCameraMove(event) {
	event.position.y += 350 * (curStep < 248 && !curSection.mustHitSection);
}

function onDadHit(event:NoteHitEvent) {
	if (curStep < 248)
		event.character = spoopyBois;
}

function spoopySubtitles(spoopy:Bool) {
	subtitles.color = 0xFFFFFFFF - 0xFF00FFB0 * spoopy;
	var daScale = 1 + 0.5 * spoopy;
	subtitles.scale.set(daScale, daScale);
}

function stepHit() {
  switch (curStep) {
	case 248:
		darken = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF000000);
		darken.scale.set(2, 2);
		darken.cameras = [camHUD];
		add(darken);
		ohNoSpoopyTime();

		spoopyBois.visible = false;
		dad.visible = true;

		healthBar.alpha = 0.5;
		healthBarBG.alpha = 0.5;
		accuracyTxt.alpha = 0.5;
		missesTxt.alpha = 0.5;
		scoreTxt.alpha = 0.5;
		for (i in 0...4) {
			cpuStrums.members[i].x -= 2000;
			playerStrums.members[i].x -= 320;
		}
	//ya guys like numbers?
	case 256, 257, 258, 259, 260, 261, 262, 263, 264, 272, 281:
		if (darken != null) {
			remove(darken);
			darken.destroy();
			darken = null;
			subtitles.text = "What have you brought me?";
		}
	case 271:
		subtitles.text = "Who's the new specimen?";
	case 290:
		subtitles.text = "Will he comply,";
	case 299:
		subtitles.text = "or has ego got the best of him?";
	case 385:
		subtitles.text = "No need to struggle.";
	case 398:
		subtitles.text = "Hush now, It'll be over soon.";
	case 417:
		subtitles.text = "No one to save you.";
	case 430:
		subtitles.text = "No way out inside your view.";
	case 516:
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
		subtitles.text = "Hush now, It'll be over soon.";
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
		subtitles.text = "Hush now, It'll be over soon.";
	case 1312:
		subtitles.text = "No one to save you.";
	case 1326:
		subtitles.text = "No way out inside your view.";
  }
}

function onPlayerHit()
	subtitles.text = "";