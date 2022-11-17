import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Position;
using Toybox.Attention;

//global variables
var lastLocation = null;
var locationAcquired = false;
var gpsQuality = null;
var isTS = false;

/*
The DiscGolfTrackerApp
*/
class DiscGolfTrackerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state){
        System.println("App Started");
        Position.enableLocationEvents( Position.LOCATION_CONTINUOUS, method( :onPosition ) );
        isTS = System.getDeviceSettings().isTouchScreen;
    }

    // onStop() is called when your application is exiting
    function onStop(state){
        System.println("App Stopped");
    }

    // // Return the initial view of your application here
    // function getInitialView() as Array<Views or InputDelegates>? {
    //     //return [ new DiscGolfTrackerView(), new DiscGolfTrackerDelegate() ] as Array<Views or InputDelegates>;
    //     return [new MainMenuView(), new MainMenuDelegate()] as Array<Views or InputDelegates>;
    // }
    // Return the initial view of your application here
    function getInitialView(){
        //push the discgolftracker view instead of main menu to increase device compatability
        return [ new DiscGolfTrackerView(), new WatchUi.BehaviorDelegate() ] as Array<Views or InputDelegates>;
    }

    //Return the settings view of the application
    function getSettingsView() {
        var settingsMenu = new WatchUi.Menu();
        settingsMenu.addItem("Units", :set_units);
        settingsMenu.addItem("Round Type", :change_round_type);
        return [settingsMenu, new SettingsDelegate()];
    }

    // Method to handle the position calls
    function onPosition(info) {
        if (locationAcquired == false){
            if (Toybox.Attention has :playTone){
                Attention.playTone(Attention.TONE_MSG);
            }
            locationAcquired = true;
        }
        var pos = info.position;
        if (pos != null) {
            lastLocation = info.position;
        }
        gpsQuality = info.accuracy;  
        WatchUi.requestUpdate();
        
       
    }

}
//Returns the app
function getApp(){
    return Application.getApp();
}