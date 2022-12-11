function create() {
    importScript("data/scripts/pixel");
    pixelNotesForBF = false;
    enableCameraHacks = false;
    enablePauseMenu = false;
    enablePixelUI = false;
}

function onSongStart()
    enablePixelUI = true;

function postCreate() {
    for (i in 0...4)
        playerStrums.members[i].cameras = [camHUD];
}

function postUpdate()
    cpuStrums.members[0].cameras[0].zoom = camHUD.zoom;

function stepHit(curStep){
    switch curStep{
        case 16:
        FlxTween.tween(FlxG.camera, {zoom: 0.7}, 1.5);
        case 20:
        defaultCamZoom = 0.7;
        case 272:
        FlxTween.tween(FlxG.camera, {zoom: 0.5}, 8.5);
        case 336:
        FlxTween.tween(FlxG.camera, {zoom: 0.7}, 8.5);
        case 784:
        FlxTween.tween(FlxG.camera, {zoom: 0.5}, 12);
    }
}