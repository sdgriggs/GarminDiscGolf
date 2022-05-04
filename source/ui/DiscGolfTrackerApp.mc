import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Position;

var lastLocation = null;


class DiscGolfTrackerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        System.println("Start App");
        Position.enableLocationEvents( Position.LOCATION_CONTINUOUS, method( :onPosition ) );
        System.println("End start function");
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        //return [ new DiscGolfTrackerView(), new DiscGolfTrackerDelegate() ] as Array<Views or InputDelegates>;
        return [new MainMenuView(), new MainMenuDelegate()] as Array<Views or InputDelegates>;
    }

    // Method to handle the position calls
    function onPosition(info) {
        lastLocation = info.position;      
       
    }

}

function getApp() as DiscGolfTrackerApp {
    return Application.getApp() as DiscGolfTrackerApp;
}