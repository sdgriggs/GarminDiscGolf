using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application.Properties;
using Toybox.Application;
using Toybox.Math;

class FieldWorkView extends WatchUi.View{

    private var manager;
    private var tempText;
    private var started;
    private static var instance;
    
    private function initialize(){
        WatchUi.View.initialize();
        reset();
    }

    public static function getInstance(){
        if (instance == null){
            instance = new FieldWorkView();
        }
        return instance;
    }

    public function reset(){
        self.started = false;
        self.manager = null;
        
        if(locationAcquired == false) {
            tempText = new WatchUi.Text({
                :text=>"Wait for GPS\nto be acquired",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
        } else {
            tempText = new WatchUi.Text({
                :text=>"Press Back To\nMark Start",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            });
        }
    }

    public function wasStarted(){
        return started;
    }

    public function startFieldWork(startLoc){
        if (Toybox.Application has :Properties){
            manager = new FieldWork(startLoc, Properties.getValue("isMetric"));
        } else{
            manager = new FieldWork(startLoc, getApp().getProperty("isMetric"));
        }
        started = true;
        tempText.setText("Press Back To\nRecord A Throw");
    }

    public function updateThrowStart(startLoc){
        if (started){
            manager.setStart(startLoc);
        }
    }

    public function getThrowsArray(){
        if (!started){
            return null;
        }
        return manager.getThrows().toArray();
    }

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
            tempText.setText("Last Throw Was:\n" + Math.round(throwList.get(throwList.getSize() - 1).getDistance()).toNumber() +unitName
            + "\nPress Back To\nRecord A Throw"
            );
        }
    }

    function onShow(){

    }

    function onUpdate(dc){
        if(self.started != true) {
            reset();
        }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        //var status = gpsQuality;
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        tempText.draw(dc);
        System.println("FW Update");
    }

}
