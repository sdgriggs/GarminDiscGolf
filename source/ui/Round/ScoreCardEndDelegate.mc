using Toybox.WatchUi;

class ScoreCardEndDelegate extends WatchUi.BehaviorDelegate{
    function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_UP);
    }
    function onNextPage(){
        if (hole > 8 && hole -  9 >= 0){
            hole = hole - 9;
        }
    }

    function onPreviousPage(){
        if (hole < Stats.getHolesCompleted(holeArray)){
            hole = hole + 9;
        }
    }
}