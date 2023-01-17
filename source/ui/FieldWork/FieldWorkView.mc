using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application.Properties;
using Toybox.Application;
using Toybox.Math;
using Toybox.System;

/*
A singleton class that displays the information of the FieldWork manager
*/
class FieldWorkView extends WatchUi.View{
    //An instance of FieldWork
    private var manager;
    //The main text that is displayed
    private var mainText;
    //If the FieldWork has been started
    private var started;
    //The FieldWorkView
    private static var instance;
    
    private function initialize(){
        WatchUi.View.initialize();
        reset();
    }

    //Returns the instance of FieldWorkView
    public static function getInstance(){
        if (instance == null){
            instance = new FieldWorkView();
        }
        return instance;
    }
    
    //Resets the FieldWorkView to its defaults
    public function reset(){
        self.started = false;
        self.manager = null;
        
        if(locationAcquired == false) {
            mainText = new WatchUi.Text({
                :text=>"Wait for GPS\nto be acquired",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
        } else { 
            if(isTS) {
                mainText = new WatchUi.Text({
                :text=>"Swipe Right To\nMark Start",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            });
            } else {
            mainText = new WatchUi.Text({
                :text=>"Press Back To\nMark Start",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            });
            }
        }
    }

    //Returns whether or not the FieldWork has been started
    public function wasStarted(){
        return started;
    }

    //Starts the FieldWork with the given start location
    public function startFieldWork(startLoc){
        if (Toybox.Application has :Properties){
            manager = new FieldWork(startLoc, Properties.getValue("isMetric"));
        } else{
            manager = new FieldWork(startLoc, getApp().getProperty("isMetric"));
        }
        started = true;
        //Display the appropriate instruction text based on if the device is touch screen
        if(isTS) {
            mainText.setText("Swipe Right To\nRecord A Throw");
        } else {
            mainText.setText("Press Back To\nRecord A Throw");
        }

    }

    //Changes the start location for subsequent throws
    public function updateThrowStart(startLoc){
        if (started){
            manager.setStart(startLoc);
        }
    }

    //Returns the throws array
    public function getThrowsArray(){
        if (!started){
            return null;
        }
        return manager.getThrows();
    }

    //adds a throw to the FieldWork
    public function addThrow(endPos){

        if (started){
            //specify proper unit name
            var unitName = "ft";
            if (Toybox.Application has :Properties && Properties.getValue("isMetric")){
                unitName = "m";
            } else if (getApp().getProperty("isMetric")){
                unitName = "m";
            }
            //Add throw and update ui text
            manager.addEndPoint(endPos);
            var throwList = manager.getThrows();
            if(isTS){
                mainText.setText("Last Throw Was:\n" + Math.round(throwList[throwList.size() - 1].getDistance()).toNumber() +unitName
                + "\nSwipe Right To\nRecord A Throw");
            } else {
                mainText.setText("Last Throw Was:\n" + Math.round(throwList[throwList.size() - 1].getDistance()).toNumber() +unitName
                + "\nPress Back To\nRecord A Throw");
            }
        }
    }

    function onUpdate(dc){
        //Reset if gps is acquired for the first time
        if(self.started != true && locationAcquired) {
            reset();
        }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        mainText.draw(dc);
    }

}
