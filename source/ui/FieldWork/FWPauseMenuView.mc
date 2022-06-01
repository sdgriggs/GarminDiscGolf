using Toybox.WatchUi;

class FWPauseMenuView extends WatchUi.Menu{
    public function initialize(){
        WatchUi.Menu.initialize();
        addItem("End Session", :end_fw);
        addItem("Resume", :resume_fw);
    }
}