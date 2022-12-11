var overlay:FlxSprite;
var coloredOverlay:FlxSprite;

function postCreate() {
    bg.loadGraphic(Paths.image('menus/bgArt'));
    if (!isSubState) {
        bg.makeGraphic(1280, 720, 0xFF515F92);
        overlay = new FlxSprite(0, 0, Paths.image('menus/bgArt'));
        overlay.color = 0xFF353E60;
        overlay.scrollFactor.set(0, 0.1);
        overlay.scale.set(1.15, 1.15);
        overlay.updateHitbox();
        overlay.x = 640 - overlay.width / 2;
        insert(members.indexOf(bg) + 1, overlay);
        coloredBG.makeGraphic(1280, 720, 0xFFE1E1E1);
        coloredOverlay = new FlxSprite(0, 0, Paths.image('menus/bgArt'));
        coloredOverlay.color = 0xFF000000;
        coloredOverlay.scrollFactor.set(0, 0.1);
        coloredOverlay.scale.set(1.15, 1.15);
        coloredOverlay.updateHitbox();
        coloredOverlay.x = 640 - overlay.width / 2;
        insert(members.indexOf(coloredBG) + 1, coloredOverlay);
    }
}

function postUpdate()
    coloredOverlay.alpha = coloredBG.alpha * 0.45;