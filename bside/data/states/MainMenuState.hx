function create()
    optionShit = ["freeplay", "options"];

function postCreate() {
    for (i in 0...2) {
        var menuItem = menuItems.members[i];
        menuItem.frames = Paths.getFrames('menus/mainMenu');
        menuItem.animation.addByPrefix('idle', optionShit[i] + " small", 24);
        menuItem.animation.addByPrefix('selected', optionShit[i] + "0", 24);
        var anim = ["selected", "idle"];
        menuItem.animation.play(anim[i], true);
        menuItem.updateHitbox();
        menuItem.x = 640 - menuItem.width / 2;
        menuItem.y = 360 - menuItem.height * 1.125;
        menuItem.y += menuItem.height * 2.25 * i;
    }
        
    members[1].makeGraphic(1280, 720, 0xFFFDE871);
    members[1].scrollFactor.set();

    var overlay:FlxSprite = new FlxSprite(0, 0, Paths.image("menus/bgArt"));
    overlay.color = 0xFFDC7928;
    overlay.scrollFactor.set();
    insert(2, overlay);

    magenta.alpha = 0;
}