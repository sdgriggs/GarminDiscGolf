using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics;
using Toybox.Application.Properties;
using Toybox.Application;
using Toybox.ActivityRecording;

/*
A singleton class that displays the information of the FieldWork manager
*/
class RoundView extends WatchUi.View{
    //The main text to be displayed
    private var mainText;
    //The number of lines of the main text
    private var mainTextLines;
    //The instance of RoundView
    private static var instance;
    //The underlying Round or SimpleRound
    private var manager;
    //Whether or not the Round was started
    private var started;
    //The text for prompting the user to use back
    private var useBackText;
    //The text for prompting the user to use select
    private var selectText;
    //The session (for FIT recording)
    private var session;
    //The number of undoneLaps
    public var undoneLaps;
    //If the Round is a SimpleRound
    private var simple;
    //Number of pages across the main round views
    private var numPages = 3;
    //index of page
    private var pageIdx = 1;
    //units of distance
    private var unitName = "ft";

    private function initialize(){
        WatchUi.View.initialize();
        reset();
    }
    //Return the RoundView
    public static function getInstance(){
        if (instance == null) {
            instance = new RoundView();
        }
        return instance;
    }
    //return the number of pages
    public function getPages(){
        return numPages;
    }

    //Return the Round/SimpleRound manager
    public function getManager(){
        return manager;
    }
    //Return the FIT Session
    public function getSession(){
        return session;
    }
    //Reset the RoundView
    public function reset(){
        session = null;
        started = false;
        manager = null;
        undoneLaps = 0;
        mainText = "";
        mainTextLines = 1;
        if(isTS){
            selectText = "Tap";
            useBackText = "Swipe Right";
        } else {
            selectText = "Press Select";
            useBackText = "Press Back";
        }
    }
    //Sets the number of holes of the round and further initializes some fields
    public function setHoles(num) {
        if (!started) {
            var isMetric;
            if (Toybox.Application has :Properties){
                isMetric = Properties.getValue("isMetric");
                simple = Properties.getValue("roundIsSimple");
            } else{
                isMetric = getApp().getProperty("isMetric");
                simple = getApp().getProperty("roundIsSimple");
            }
            if (simple) {
                manager = new SimpleRound(num);
            } else {
                manager = new Round(num, isMetric);
            }
            started = true;

            if (Toybox has :ActivityRecording) {
                session = ActivityRecording.createSession({
                    :sport=>ActivityRecording.SPORT_GENERIC,
                    :subSport=>ActivityRecording.SUB_SPORT_GENERIC,
                    :name=>"Disc Golf",

                });
                session.start();
            }
        }
    }
    //Return if the Round has been started
    public function wasStarted(){
        return started;
    }
    //Update the displayed text
    private function updateText(){
        var holeInfo = manager.getCurrentHoleInfo();

        if (manager.isCompleted()) {
            mainText = "Round Complete:\n" + selectText + " To\nSave Round";
            mainTextLines = 3;
        }
        else if (!locationAcquired) {
            mainText = "Wait for GPS\nto be acquired";
            mainTextLines = 2;
        }
        else if (manager.needsInitializing()) {
            mainText = "Hole " + holeInfo[1] + ":\n";
            var x = manager.getLastThrow();
            
            if(!simple && x != null){
                mainText += "Last Throw: " +  Math.round(x.getDistance()).toNumber() + " " + unitName + "\n";
            }
            mainText += useBackText + " To\nSet Par";
            mainTextLines = 4;
        }
        else if (!holeInfo[0]) { //if the tee hasn't been marked
            mainText = "Hole " + holeInfo[1] + ":\n" ;
            var x = manager.getLastThrow();
            
            if(!simple && x != null){
                mainText += "Last Throw: " +  Math.round(x.getDistance()).toNumber() + " " + unitName + "\n";
            }
            
            mainText += useBackText + " To\nMark Tee";
            mainTextLines = 4;
        }
        else {
            if (simple) {
                mainText = "Hole " + holeInfo[1] + ":\n" + useBackText + " To\nSet Score";
                mainTextLines = 3;
            } else {
                var x = manager.getLastThrow();
                
                if(x != null) {
                    mainText = "Hole " + holeInfo[1] + ":\n"  +  "Throwing: " + (holeInfo[3] + 1) + "\n" + "Last Throw: " + Math.round(x.getDistance()).toNumber() + " " + unitName + "\n" + useBackText + " To\nMark Throw" ;
                } else {
                    mainText = "Hole " + holeInfo[1] + ":\n" + "Throwing: " + (holeInfo[3] + 1) + "\n" 
            + useBackText + " To\nMark Throw" ;
                }
                    mainTextLines = 5;
            }
        }
    }
    //Unpause the session if applicable
    function onShow(){
        if(session != null && !session.isRecording()) {
            session.start();
        }
        if (Toybox.Application has :Properties && Properties.getValue("isMetric")){
            unitName = "m";
        } else if (getApp().getProperty("isMetric")){
            unitName = "m";
        }

    }
    //Update the screen
    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        GraphicsUtil.showPageBar(dc, numPages, pageIdx);
        if (manager != null){
            updateText();
        }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - .5 * mainTextLines * dc.getFontHeight(Graphics.FONT_SYSTEM_SMALL), Graphics.FONT_SYSTEM_SMALL, mainText, Graphics.TEXT_JUSTIFY_CENTER);
    }

}
