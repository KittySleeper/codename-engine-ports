import funkin.system.MusicBeatState;

function update() {
	if (FlxG.keys.justPressed.SIX) {
		var state = new MusicBeatState(true, "CharEdit");
		state.stateScript.set("daAnim", dad.curCharacter);
		FlxG.switchState(state);
	}
}