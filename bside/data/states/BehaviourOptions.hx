function postCreate() {
	bg.makeGraphic(1280, 720, 0xFF515F92);
	overlay = new FlxSprite(0, 0, Paths.image('menus/bgArt'));
	overlay.color = 0xFF353E60;
	overlay.scrollFactor.set(0, 0.1);
	overlay.scale.set(1.15, 1.15);
	overlay.updateHitbox();
	overlay.screenCenter();
	insert(members.indexOf(bg) + 1, overlay);

	descBG.makeGraphic(1, 1, 0x90000000);
}