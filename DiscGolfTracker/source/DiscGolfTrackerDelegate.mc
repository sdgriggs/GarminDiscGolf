import Toybox.Lang;
import Toybox.WatchUi;

var teeLocation = null;

class DiscGolfTrackerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() as Boolean {
        WatchUi.pushView(new Rez.Menus.PinMenu(), new PinMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}

class PinMenuDelegate extends WatchUi.MenuInputDelegate {


    public function initalize() {
        MenuInputDelegate.initialize();
    }

    public function onMenuItem(item) {
        if( item == :Tee) {
            
            teeLocation = lastLocation;
            System.println("TEE WAS PRESSED: " + teeLocation.toDegrees()[0]);
        } else if (item == :Disc) {
            discLocation = lastLocation;
            var distance = distanceBetweenLocations(teeLocation, discLocation);
            System.println("DISC WAS PRESSED");
        }
        else {
            System.println("WHAT EVEN HAPPENED???");
        }
    }


    private function distanceBeteweenLocations(a, b){
        var lonA = a.toDegrees()[0];
        var latA = a.toDegrees()[1];
        var lonB = b.toDegrees()[0];
        var latB = b.toDegrees()[1];
    }
}