import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;

var bitmaps = [];
var cabXML:String;

function create() {
	/*var sprites = [];
	for (preload in ["bg-evil", "pillar-evil", "cabinets-evil", "vignette"]) {
		var sprite = new FlxSprite(0, 0, Paths.image("stages/bside-spoopy/" + preload));
		add(sprite);
		sprites.push(sprite);
	}
	var timer = new FlxTimer().start(0.1, function(tmr:FlxTimer) {
		for (sprite in sprites) {
			remove(sprite);
			sprite.destroy();
		}
	});*/
	for (preload in ["bg-evil", "pillar-evil", "cabinets-evil", "vignette"]) {
		bitmaps.push(Assets.getBitmapData(Paths.image("stages/bside-spoopy/" + preload)));
	}
	cabXML = Assets.getText(Paths.file('images/stages/bside-spoopy/cabinets-evil.xml'));
}

function postCreate()
	scripts.publicVariables.set("ohNoSpoopyTime", ohNoSpoopyTime);

function ohNoSpoopyTime() {
	gf.visible = false;

	bg.loadGraphic(bitmaps[0]);
	pillar.loadGraphic(bitmaps[1]);
	cabinets.frames = FlxAtlasFrames.fromSparrow(bitmaps[2], cabXML);
	cabinets.animation.addByPrefix("idle", "");
	cabinets.animation.play("idle");

	var vig = new FlxSprite(0, 0, bitmaps[3]);
	vig.alpha = 0.65;
	vig.cameras = [camHUD];
	vig.setGraphicSize(1280, 720);
	vig.updateHitbox();
	vig.scrollFactor.set();
	add(vig);
}