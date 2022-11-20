var hurtnotemissed:Int = 0;

function onNoteMiss(){
    if (note.noteType == "Hurt Note"){
        hurtnotemissed++;
        trace('you have ' + hurtnotemissed + ' hurt notes missed good job');
}
function onPlayerHit() {
    if (note.noteType == "Hurt Note"){
        combo = 0;
		songScore -= 10;
		misses++;
    }
}
}