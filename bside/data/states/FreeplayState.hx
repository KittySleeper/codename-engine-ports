import funkin.ui.Alphabet;
import StringTools;

function postCreate() {
    for (song in songs)
        song.color = 0xFFFFFFFF;
    bg.makeGraphic(1280, 720, 0xFF9271FD);
    bg.color = 0xFFFFFFFF;
    var overlay = new FlxSprite(0, 0, Paths.image("menus/bgArt"));
    overlay.antialiasing = true;
    overlay.color = 0xFF2746DC;
    insert(members.indexOf(bg) + 1, overlay);
    remove(diffText);

    for (bet in grpSongs.members)
        bet.destroy();
    grpSongs.clear();

    for (i in 0...songs.length) {
        var songName = songs[i].songName;
        if (StringTools.endsWith(songName, "-Bside")) songName = songName.substring(0, songName.length - 6);

		var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songName, true, false);
		songText.isMenuItem = true;
		songText.targetY = i;
		grpSongs.add(songText);
        iconArray[i].sprTracker = songText;
	}
}

function postUpdate() {
    scoreBG.scale.y = 43;
    scoreBG.updateHitbox();
}