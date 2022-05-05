using Toybox.WatchUi;

class FWPauseMenuDelegate extends WatchUi.MenuInputDelegate{

    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item){
        if (item == :end_fw){
            WatchUi.popView(WatchUi.SLIDE_LEFT);
        } else if (item == :resume_fw){
            //macht nichts
        }
    }
}