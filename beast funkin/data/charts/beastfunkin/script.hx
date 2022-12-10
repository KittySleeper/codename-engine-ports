import flixel.FlxSprite;

var text:FlxSprite = null;

function create() {
    text = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/beach/text thing'));
    text.screenCenter();
    text.scrollFactor.set(0, 0);
    add(text);
}

function stepHit(curStep){
    switch curStep{
        case 25:
        FlxTween.tween(text, {alpha: 0}, 0.7);
    }
}