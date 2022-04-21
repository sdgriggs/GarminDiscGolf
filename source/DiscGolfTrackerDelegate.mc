import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Math as Math;
var teeLocation = null;

    // modified from https://www.geeksforgeeks.org/program-distance-two-points-earth/#:~:text=For%20this%20divide%20the%20values,is%20the%20radius%20of%20Earth.
    // Function to find the distance between two location objects
    public function distanceBeteweenLocations(a, b){
        var lon1 = a.toRadians()[1];
        var lon2 = b.toRadians()[1];
        var lat1 = a.toRadians()[0];
        var lat2 = b.toRadians()[0];
 
        // Haversine formula
        var dlon = lon2 - lon1;
        var dlat = lat2 - lat1;
        var v = Math.pow(Math.sin(dlat / 2), 2)
                 + Math.cos(lat1) * Math.cos(lat2)
                 * Math.pow(Math.sin(dlon / 2),2);
             
        var c = 2 * Math.asin(Math.sqrt(v));
 
        // Radius of earth in kilometers. Use 3956
        // for miles
        var r = 6371;
 
        // calculate the result
        return(c * r) * 1000;
    }


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
            var discLocation = lastLocation;
            var distance = distanceBeteweenLocations(teeLocation, discLocation);
            System.println("DISC FLEW" + distance + "m");
        }
        else {
            System.println("WHAT EVEN HAPPENED???");
        }
    }

    
}