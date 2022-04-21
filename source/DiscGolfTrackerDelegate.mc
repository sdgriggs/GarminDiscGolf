import Toybox.Lang;
import Toybox.WatchUi;

class DiscGolfTrackerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new DiscGolfTrackerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}