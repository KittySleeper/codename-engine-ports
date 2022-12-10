import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import lime.app.Application;
import lime.ui.Window;

var click_text:FlxText = null;
var cookies_clicked:Int = 0;
var cookie:FlxSprite = null;

function create() {
    FlxG.mouse.enabled = true;
    FlxG.mouse.visible = true;
    var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('cookieclickerassets/backround v1'));
    bg.antialiasing = true;
    bg.scale.set(1.3, 2);
    bg.screenCenter();
    add(bg);

    var cookie_anim = Paths.getSparrowAtlas('cookieclickerassets/cookie');

    cookie = new FlxSprite(19.8, 275.7);
    cookie.frames = cookie_anim;
    cookie.animation.addByPrefix('idle', 'cookie static');
    cookie.animation.addByPrefix('press', 'cookie press', 54, false);
    cookie.animation.play('idle');
    cookie.antialiasing = true;
    cookie.pixelPerfectPosition = true;
    add(cookie);

    click_text = new FlxText(221.6, 215.2, 0, "", 50);
    add(click_text);

    if (FlxG.save.data.cookiesthatgotclicked != cookies_clicked)
        cookies_clicked = FlxG.save.data.cookiesthatgotclicked;
}

function click() {
    cookies_clicked += 1;
    cookie.animation.play('press');
    FlxG.save.data.cookiesthatgotclicked = cookies_clicked;
    FlxG.save.flush();
    if(cookies_clicked == 100)
    Application.current.window.alert("CONGRAGULATIONS", "you have 100 clicks impresive");
}

function update() {
    click_text.text = "" + cookies_clicked;
    if (FlxG.mouse.overlaps(cookie) && FlxG.mouse.justPressed)
    click();
}