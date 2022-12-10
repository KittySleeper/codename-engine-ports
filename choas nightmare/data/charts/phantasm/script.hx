import flixel.FlxG;
import flixel.FlxSprite;

var staticcoolness:FlxSprite = null;
var bgsonic:FlxSprite = null;
var bgfleet:FlxSprite = null;

function postCreate() {
    defaultCamZoom = 0.8;
    dad.visible = false;
    gf.alpha = 0;

    staticcoolness = new FlxSprite(0, 0);
    staticcoolness.frames = Paths.getSparrowAtlas('stages/plantasim like prisim/staticie');
    staticcoolness.animation.addByPrefix('idle', 'idle', true);
    staticcoolness.animation.play('idle', true);
    staticcoolness.scale.set(3, 3);
    staticcoolness.screenCenter();
    staticcoolness.visible = false;
    add(staticcoolness);
}

function create() {
    bgsonic = new FlxSprite(-254.4, 20).loadGraphic(Paths.image('stages/plantasim like prisim/sonic'));
    bgsonic.antialiasing = true;
    add(bgsonic);

    bgfleet = new FlxSprite(-254.4, 20).loadGraphic(Paths.image('stages/plantasim like prisim/fleet'));
    bgfleet.antialiasing = true;
    bgfleet.visible = false;
    add(bgfleet);
}

function chaosswitch(fleet:Bool) {
    FlxG.sound.play((Paths.sound('stat')), 1, false);
    staticcoolness.visible = true;
    FlxTween.tween(staticcoolness, {alpha: 0.0001}, 0.4);
    
    if(fleet == true){
        dad.visible = true;
        bgfleet.visible = true;
        boyfriend.visible = false;
        bgsonic.visible = false;
    }else{
        dad.visible = false;
        bgfleet.visible = false;
        boyfriend.visible = true;
        bgsonic.visible = true;
    }
}

function update() {
    if(staticcoolness.alpha == 0.0001){
        staticcoolness.alpha = 1;
        staticcoolness.visible = false;
    }
}

function stepHit(curStep){
    switch curStep{
        case 386:
            chaosswitch(true);
        case 640:
            chaosswitch(false);
        case 767:
            chaosswitch(true);
        case 1023:
            chaosswitch(false);
        case 1279:
            chaosswitch(true);
        case 1407:
            chaosswitch(false);
        case 1535:
            chaosswitch(true);
        case 1791:
            chaosswitch(false);
    }
}