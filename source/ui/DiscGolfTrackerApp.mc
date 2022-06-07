import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Position;
using Toybox.Attention;

var lastLocation = null;
var locationAcquired = false;
var gpsQuality = null;
var isTS = false;

class DiscGolfTrackerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state){
        System.println("Start App");
        Position.enableLocationEvents( Position.LOCATION_CONTINUOUS, method( :onPosition ) );
        isTS = System.getDeviceSettings().isTouchScreen;
        System.println("IS TS:" + isTS);
        System.println("End start function");
    }

    // onStop() is called when your application is exiting
    function onStop(state){
    }

    // // Return the initial view of your application here
    // function getInitialView() as Array<Views or InputDelegates>? {
    //     //return [ new DiscGolfTrackerView(), new DiscGolfTrackerDelegate() ] as Array<Views or InputDelegates>;
    //     return [new MainMenuView(), new MainMenuDelegate()] as Array<Views or InputDelegates>;
    // }
    // Return the initial view of your application here
    function getInitialView(){
        //push the discgolftracker view instead of main menu to increase device compatability
        return [ new DiscGolfTrackerView(), new DiscGolfTrackerDelegate() ] as Array<Views or InputDelegates>;
        //return [new MainMenuView(), new MainMenuDelegate()];
    }

    //Return the settings view of the application
    function getSettingsView() {
        return [new SettingsView(), new SettingsDelegate()];
    }

    // Method to handle the position calls
    function onPosition(info) {
        if (locationAcquired == false){
            if (Toybox.Attention has :playTone){
                Attention.playTone(Attention.TONE_MSG);
            }
            locationAcquired = true;
        }
        lastLocation = info.position;
        gpsQuality = info.accuracy;  
        System.println("GPSQuality: " + gpsQuality);
        WatchUi.requestUpdate();
        
       
    }

}

function getApp(){
    return Application.getApp();
}