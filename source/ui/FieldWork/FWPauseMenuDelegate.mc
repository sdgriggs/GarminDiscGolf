using Toybox.WatchUi;

class FWPauseMenuDelegate extends WatchUi.MenuInputDelegate{

    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item){
        if (item == :end_fw){

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            var arr = FieldWorkView.getInstance().getThrowsArray();
            if (arr != null && arr.size() > 0){
                WatchUi.switchToView(new FWStatsView(arr), null, WatchUi.SLIDE_RIGHT);
            } else {
                //WatchUi.popView(WatchUi.SLIDE_LEFT);
            }
            FieldWorkView.getInstance().reset();
        } else if (item == :resume_fw){
            //macht nichts
        }
    }
}