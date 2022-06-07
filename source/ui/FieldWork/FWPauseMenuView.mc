using Toybox.WatchUi;

class FWPauseMenuView extends WatchUi.Menu{
    public function initialize(){
        WatchUi.Menu.initialize();
        addItem("Resume", :resume_fw);
        addItem("End Session", :end_fw);
        
    }
}