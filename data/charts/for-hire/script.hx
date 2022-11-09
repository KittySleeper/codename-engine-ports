function stepHit(curStep){
    switch curStep{
        case 16:
        FlxTween.tween(FlxG.camera, {zoom: 0.7}, 1.5);
        case 20:
        defaultCamZoom = 0.7;
    }
}