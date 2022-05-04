import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Math as Math;
using Stats;
var teeLocation = null;

class DiscGolfTrackerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    // function onBack() as Boolean {
    //     WatchUi.pushView(new Rez.Menus.PinMenu(), new PinMenuDelegate(), WatchUi.SLIDE_UP);
    //     return true;
    // }

}

// class PinMenuDelegate extends WatchUi.MenuInputDelegate {


//     public function initialize() {
//         MenuInputDelegate.initialize();
//     }

//     public function onMenuItem(item) {
//         if( item == :Tee) {
            
//             teeLocation = lastLocation;
//             System.println("TEE WAS PRESSED: " + teeLocation.toDegrees()[0]);
//         } else if (item == :Disc) {
//             var discLocation = lastLocation;
//             var distance = Stats.measureDistanceBetweenLocations(teeLocation, discLocation);//distanceBeteweenLocations(teeLocation, discLocation);
//             System.println("DISC FLEW" + distance + "m");
//         }
//         else {
//             System.println("WHAT EVEN HAPPENED???");
//         }
//     }

    
// }