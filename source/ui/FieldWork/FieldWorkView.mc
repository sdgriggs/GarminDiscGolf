using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application.Properties;

class FieldWorkView extends WatchUi.View{

    private var manager;
    private var tempText;
    private var started;
    private static var instance;
    
    private function initialize(){
        WatchUi.View.initialize();
        self.started = false;
        tempText = new WatchUi.Text({
            :text=>"Press Lap To Mark Start",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_SMALL,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }

    public static function getInstance(){
        if (instance == null){
            instance = new FieldWorkView();
        }
        return instance;
    }

    public function wasStarted(){
        return started;
    }

    public function startFieldWork(startLoc){
        manager = new FieldWork(startLoc, Properties.getValue("isMetric"));
        started = true;
        tempText.setText("Press Lap To\nRecord A Throw");
    }

    public function updateThrowStart(startLoc){
        if (started){
            manager.setStart(startLoc);
        }
    }

    public function addThrow(endPos){

        if (started){
            //specify proper unit name
            var unitName = "ft";
            if (Properties.getValue("isMetric")){
                unitName = "m";
            }
            //Add throw and update ui text
            manager.addEndPoint(endPos);
            var throwList = manager.getThrows();
            tempText.setText("Last Throw Was:\n" + throwList.get(throwList.getSize() - 1).getDistance() +unitName
            + "\nPress Lap To\nRecord A Throw"
            );
        }
    }

    function onShow(){

    }

    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        tempText.draw(dc);
    }

}
