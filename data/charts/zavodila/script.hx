function shake(Value:Bool) {
    FlxG.camera.shake(Value);
    gf.playAnim('scared');
    boyfriend.playAnim('scared');
}

function onDadHit(){
    shake(0.01);
}