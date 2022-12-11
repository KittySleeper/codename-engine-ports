import funkin.menus.TitleState;
import funkin.cutscenes.VideoCutscene;
import funkin.system.CoolUtil;

var ogInit:Bool = false;

function create() {
    ogInit = TitleState.initialized;
    TitleState.initialized = true;
}

function postCreate() {
    if (ogInit) return;
    openSubState(new VideoCutscene(Paths.video("bIntro"), function() {
        CoolUtil.playMenuSong(false);
        FlxG.camera.flash(0xFFFFFFFF, 0.5);
    }));
}