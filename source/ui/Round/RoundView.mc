using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics;
using Toybox.Application.Properties;
using Toybox.Application;
using Toybox.ActivityRecording;

class RoundView extends WatchUi.View{
    private var mainText;

    private var mainTextLines;

    private static var instance;

    private var manager;

    private var started;

    private var useBackText;

    private var selectText;

    private var session;

    public var undoneLaps;

    private var simple;

    private function initialize(){
        WatchUi.View.initialize();
        reset();
    }

    public static function getInstance(){
        if (instance == null) {
            instance = new RoundView();
        }
        return instance;
    }

    public function getManager(){
        return manager;
    }

    public function getSession(){
        return session;
    }

    public function reset(){
        session = null;
        started = false;
        manager = null;
        undoneLaps = 0;
        // mainText = new WatchUi.Text({
        //     :text=>"",
        //     :color=>Graphics.COLOR_WHITE,
        //     :font=>Graphics.FONT_SYSTEM_SMALL,
        //     :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
        //     :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        // });
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

    public function wasStarted(){
        return started;
    }

    private function updateText(){
        var holeInfo = manager.getCurrentHoleInfo();

        //temp memory stuff
        //var sysStats = System.getSystemStats();
        if (manager.isCompleted()) {
            mainText = "Round Complete:\n" + selectText + " To\nSave Round";
            mainTextLines = 3;
        }
        else if (!locationAcquired) {
            mainText = "Wait for GPS\nto be acquired";
            mainTextLines = 2;
        }
        else if (manager.needsInitializing()) {
            mainText = "Hole " + holeInfo[1] + ":\n" + useBackText + " To\nSet Par";
            mainTextLines = 3;
        }
        else if (!holeInfo[0]) { //if the tee hasn't been marked
            mainText = "Hole " + holeInfo[1] + ":\n" + useBackText + " To\nMark Tee";
            mainTextLines = 3;
        }
        else {
            if (simple) {
                mainText = "Hole " + holeInfo[1] + ":\n" + useBackText + " To\nSet Score";
                mainTextLines = 3;
            } else {
                mainText = "Hole " + holeInfo[1] + ":\n" +"Throwing: " + (holeInfo[3] + 1) + "\n" 
                + useBackText + " To\nMark Throw";
                mainTextLines = 4;
            }
        }
    }

    function onShow(){
        if(session != null && !session.isRecording()) {
            session.start();
        }

    }

    function onUpdate(dc){
        // if(self.started != true) {
        //     reset();
        // }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        //var status = gpsQuality;
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        GraphicsUtil.showPageBar(dc, 2, 1);
        if (manager != null){
            updateText();
        }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - .5 * mainTextLines * dc.getFontHeight(Graphics.FONT_SYSTEM_SMALL), Graphics.FONT_SYSTEM_SMALL, mainText, Graphics.TEXT_JUSTIFY_CENTER);
        System.println("Round Update");
    }

}
