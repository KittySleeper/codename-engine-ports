function postCreate() {
	var normAnimFinished = gf.animation.finishCallback;
	var normOnDance = gf.script.get("onDance");
	gf.animation.finishCallback = function(animName:String) {
		gf.script.set("onDance", normOnDance);
		if (normAnimFinished != null)
			normAnimFinished(animName);
	};
}

function stepHit(curStep:Int) {
   if ([122, 186, 314, 378, 442].contains(curStep)) {
	gf.playAnim("youGotThis", true);
	gf.script.set("onDance", function(event) {
		event.cancel();
	});
   }
}

//this is in the future