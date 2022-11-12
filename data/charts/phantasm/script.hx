import flixel.FlxG;
import flixel.FlxSprite;

var staticcoolness:FlxSprite = null;

function create() {
    dad.visible = false;
    gf.visible = false;

    staticcoolness = new FlxSprite(0, 0);
    staticcoolness.frames = Paths.getSparrowAtlas('stages/plantasim like prisim/staticie');
    staticcoolness.animation.addByPrefix('idle', 'idle', true);
    staticcoolness.animation.play('idle', true);
    staticcoolness.pixelPerfectPosition = true;
    staticcoolness.visible = false;
    add(staticcoolness);
}

function chaosswitch(fleet:Bool) {
    staticcoolness.visible = true;
    FlxTween.tween(staticcoolness, {alpha: 0.0001}, 0.6);
    if(fleet == true){
        dad.visible = true;
        boyfriend.visible = false;
    }else{
        dad.visible = false;
        boyfriend.visible = true;
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