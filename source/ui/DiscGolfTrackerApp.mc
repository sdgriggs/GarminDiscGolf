import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Position;
using Toybox.Attention;

var lastLocation = null;
var locationAcquired = false;


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

    //Return the settings view of the application
    function getSettingsView() {
        return [new SettingsView(), new SettingsDelegate()];
    }

    // Method to handle the position calls
    function onPosition(info) {
        if (locationAcquired == false){
            Attention.playTone(Attention.TONE_MSG);
            locationAcquired = true;
        }
        lastLocation = info.position;      
       
    }

}

function getApp() as DiscGolfTrackerApp {
    return Application.getApp() as DiscGolfTrackerApp;
}