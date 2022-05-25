import Toybox.Graphics;
import Toybox.WatchUi;

class DiscGolfTrackerView extends WatchUi.View {
    private var loaded;
    function initialize() {
        View.initialize();
        loaded = false;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        //setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        //If the app just started open the main menu
        if (!loaded){
            WatchUi.pushView(new MainMenuView(), new MainMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
            loaded = true;
        } else {//if someone pressed back on the main menu, close the app
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}

