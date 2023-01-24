import Toybox.Graphics;
import Toybox.WatchUi;

/*
A temporary initial view that pushes the menu onto the view stack. Some devices
don't support the menu being the base view, so this improves device compatability.
*/
class DiscGolfTrackerView extends WatchUi.View {
    //if the app has been loaded
    private var loaded;
    function initialize() {
        View.initialize();
        loaded = false;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        //If the app just started open the main menu
        if (!loaded){
            var menu = new WatchUi.Menu();
            menu.addItem("Play Round", :round);
            menu.addItem("Field Work", :fw);
            menu.addItem("Settings", :settings);
            WatchUi.pushView(menu, new MainMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
            loaded = true;
        } else {//if someone pressed back on the main menu, close the app
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }
}

