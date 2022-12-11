if (PlayState.SONG.song.toLowerCase() == "shiver") {
	import flixel.util.FlxTimer;

	var normSprites = [bg, pillar, cabinets];
	var ebilSprites = [];
	
	function create() {
		var ebilBG = bg.clone();
		ebilBG.loadGraphic(Paths.image("stages/bside-spoopy/bg-evil"));
		ebilSprites.push(ebilBG);
		ebilBG.x = bg.x - 300;
		ebilBG.y = bg.y - 200;
		add(ebilBG);
	
		var ebilPil = pillar.clone();
		ebilPil.loadGraphic(Paths.image("stages/bside-spoopy/pillar-evil"));
		ebilSprites.push(ebilPil);
		ebilPil.x = pillar.x;
		ebilPil.y = pillar.y;
		add(ebilBG);
	
		var ebilCab = cabinets.clone();
		ebilCab.frames = Paths.getSparrowAtlas("stages/bside-spoopy/cabinets-evil");
		ebilCab.animation.addByPrefix("idle", "");
		ebilSprites.push(ebilCab);
		ebilCab.x = cabinets.x;
		ebilCab.y = cabinets.y;
		add(ebilCab);
	
		var vig = new FlxSprite(0, 0, Paths.image("stages/bside-spoopy/vignette"));
		vig.setGraphicSize(1280, 720);
		vig.cameras = [camHUD];
		vig.updateHitbox();
		vig.alpha = 0.65;
		ebilSprites.push(vig);
		add(vig);
	
		var timer = new FlxTimer().start(0.1, function(tmr:FlxTimer) {
			for (sprite in ebilSprites)
				remove(sprite);
		});
	}
	
	function postCreate()
		scripts.publicVariables.set("ohNoSpoopyTime", ohNoSpoopyTime);
	
	function ohNoSpoopyTime() {
		gf.visible = false;
	
		for (i in 0...normSprites.length) {
			remove(normSprites[i]);
			add(ebilSprites[i]);
			stage.stageSprites.set(normSprites[i].name, ebilSprites[i]);
			normSprites[i].destroy();
		}
		add(ebilSprites[3]);
		stage.stageSprites.set("vignette", ebilSprites[3]);
	}

	function beatHit(curBeat:Int) {
		if (curBeat >= 62)
			ebilSprites[2].animation.play("idle", true);
	}
}