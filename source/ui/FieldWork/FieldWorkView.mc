using Toybox.WatchUi;
using Toybox.Graphics;

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
        //TODO: Add settings functionality (probably another singleton class)
        manager = new FieldWork(startLoc, false);
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
            manager.addEndPoint(endPos);
                        var throwList = manager.getThrows();
            tempText.setText("Last Throw Was:\n" + throwList.get(throwList.getSize() - 1).getDistance() +"ft"
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
