var pico:Character;
var mom:Character;
var spookyboiz:Character;

function createPost() {
    gf.visible = false;
}

function create() {
    pico = new Character(boyfriend.x - 497.3, boyfriend.y, 'pico', true);
    add(pico);

    mom = new Character(boyfriend.x + 10, boyfriend.y, 'mom', true);
    add(mom);

    spookyboiz = new Character(boyfriend.x - 120, boyfriend.y + 8.4, 'spooky', true);
    add(spookyboiz);
}

function stepHit(curStep){
    switch curStep{
        case 1:
            pico.visible = false;
            mom.visible = false;
            spookyboiz.visible = false;
        case 128://LIKE LEATHER128 REAL
            FlxG.camera.flash(0xFFFFFF, 0.8);
            defaultCamZoom = 1.4;
        case 256:
            FlxG.camera.flash(0xFFFFFF, 0.8);
            defaultCamZoom = 0.9;
        case 767:
            FlxG.camera.flash(0xFFFFFF, 0.8);
            boyfriend.visible = false;
            pico.visible = true;
}
}