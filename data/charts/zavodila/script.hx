function shake(Value:Bool, Anim:String) {
    FlxG.camera.shake(Value);
    gf.playAnim(Anim);
    boyfriend.playAnim(Anim);
}

function onDadHit(){
    shake(0.01, 'scared');
}