using Toybox.WatchUi;
/*
The delegate for the FieldWork pause menu
*/
class FWPauseMenuDelegate extends WatchUi.MenuInputDelegate{

    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item){
        if (item == :end_fw){
            //Exit field work if End Session was selected
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            var arr = FieldWorkView.getInstance().getThrowsArray();
            //Switch to the stats view if there were throws
            if (arr != null && arr.size() > 0){
                WatchUi.switchToView(new FWStatsView(arr), new FWStatsDelegate(), WatchUi.SLIDE_RIGHT);
            }
            //Reset the FieldWorkView to save memory
            FieldWorkView.getInstance().reset();
        } else if (item == :resume_fw){
            //macht nichts
        }
    }
}