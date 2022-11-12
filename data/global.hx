import ("note");
import("flixel.util.FlxAxes");

function oopponentNoteHit(direction:Int){
    switch direction{
        case 0:
            FlxTween.tween(FlxG.camera, {x: 43}, 0.5);
        case 1:
            FlxTween.tween(FlxG.camera, {x: 65}, 0.5);
        case 2:
            FlxTween.tween(FlxG.camera, {x: 65}, 0.5);
        case 3:
            FlxTween.tween(FlxG.camera, {x: -76}, 0.5);
    }
}