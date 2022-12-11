import funkin.windows.WindowsAPI;

function create() {
	//Making the volume weird so it knows it's playing settings music.
	if (FlxG.sound.music != null && FlxG.sound.music.volume != 0.9786)
		FlxG.sound.playMusic(Paths.music('configurator'), 0.9786, true);

	options[4].name = "Open Debug Log";
}

function postCreate() {
	members[0].loadGraphic(Paths.image("menus/bgArt"));
	members[0].color = 0xFF353E60;
	members[0].y = -20;
	var bg = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF515F92);
	insert(0, bg);
}

var openedDebug:Bool = false;
function update() {
	if (controls.UP_P || controls.DOWN_P) {
		var daSelected = curSelected + (controls.DOWN_P) ? 1 : -1;
		lerpY = 10 * daSelected - 20;
	}
	var selectedThing = (controls.ACCEPT && alphabets.members[curSelected] != null);
	if (selectedThing && curSelected == 4) {
		canSelect = false;
		openedDebug = true;
		WindowsAPI.allocConsole();
	} else if (!selectedThing && controls.BACK)
		FlxG.sound.music.stop();
}

function postUpdate() {
	if (openedDebug) {
		canSelect = true;
		openedDebug = false;
	}
	members[1].y = FlxMath.lerp(-5 * (curSelected - 2) - 10, members[1].y, 0.95);
}