using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application.Properties;
using Toybox.Application;
using Toybox.ActivityRecording;

class RoundView extends WatchUi.View{
    private var mainText;

    private static var instance;

    private var manager;

    private var started;

    private var useBackText;

    private var session;

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
        mainText = new WatchUi.Text({
            :text=>"",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_SYSTEM_SMALL,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
        if(isTS){
            useBackText = "Swipe Right";
        } else {
            useBackText = "Press Back";
        }
    }

    public function setHoles(num) {
        if (!started) {
            if (Toybox.Application has :Properties){
                manager = new Round(num, Properties.getValue("isMetric"));
            } else{
                manager = new Round(num, getApp().getProperty("isMetric"));
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

    function onShow(){
        if(session != null && !session.isRecording()) {
            //session.start();
        }

    }

    private function updateText(){
        var holeInfo = manager.getCurrentHoleInfo();
        if (!locationAcquired) {
            mainText.setText("Wait for GPS\nto be acquired");
        }
        else if (manager.needsInitializing()) {
            mainText.setText("Hole " + holeInfo[1] + ":\n" + useBackText + " To\nSet Par");
        }
        else if (!holeInfo[0]) { //if the tee hasn't been marked
            mainText.setText("Hole " + holeInfo[1] + ":\n" + useBackText + " To\nMark Tee");
        }
        else {
            mainText.setText("Hole " + holeInfo[1] + ":\n" + useBackText + " To\nMark Throw");
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

        mainText.draw(dc);
        System.println("Round Update");
    }

}
