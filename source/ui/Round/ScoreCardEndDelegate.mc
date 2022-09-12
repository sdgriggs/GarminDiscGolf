using Toybox.WatchUi;

class ScoreCardEndDelegate extends WatchUi.BehaviorDelegate{
    function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_UP);
        return true;
    }
    (:notForLSD)
    function onNextPage(){
        downBehavior();
        return true;
    }
    (:notForLSD)
    function onPreviousPage(){
        upBehavior();
        return true;
    }

    function onSwipe(swipeEvent) {
        if (swipeEvent.getDirection() == WatchUi.SWIPE_UP) {
            upBehavior();
        } else if (swipeEvent.getDirection() == WatchUi.SWIPE_DOWN) {
            downBehavior();
        }
    }

    private function upBehavior() {
        if (hole < Stats.getHolesCompleted(holeArray)){
            hole = hole + 9;
        } 
    }

    private function downBehavior() {
        if (hole > 8 && hole -  9 >= 0){
            hole = hole - 9;
        }
    }
}