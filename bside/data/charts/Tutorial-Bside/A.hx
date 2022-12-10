function stepHit(curStep:Int) {
  if ([122, 186, 314, 378, 442].contains(curStep))
    PlayState.instance.gf.playAnim("youGotThis");
}
