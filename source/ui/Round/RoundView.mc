using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application.Properties;
using Toybox.Application;

class RoundView extends WatchUi.View{
    private var tempText;

    private static var instance;

    private var manager;

    private var started;

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

    public function reset(){
        started = false;
        manager = null;
    }

    public function setHoles(num) {
        if (!started) {
            if (Toybox.Application has :Properties){
                manager = new Round(num, Properties.getValue("isMetric"));
            } else{
                manager = new Round(num, getApp().getProperty("isMetric"));
            }
            started = true;
        }
    }

    public function wasStarted(){
        return started;
    }

    function onShow(){
        tempText = new WatchUi.Text({
            :text=>"Not Yet Implemented",
            :color=>Graphics.COLOR_RED,
            :font=>Graphics.FONT_MEDIUM,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }

    function onUpdate(dc){
        // if(self.started != true) {
        //     reset();
        // }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        //var status = gpsQuality;
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        tempText.draw(dc);
        System.println("Round Update");
    }

}
