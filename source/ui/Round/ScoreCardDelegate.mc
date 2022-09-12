using Toybox.WatchUi;

class ScoreCardDelegate extends WatchUi.BehaviorDelegate{
    function initialize() {
        WatchUi.BehaviorDelegate.initialize();
    }
    //Not for lateral swipe devices
    (:notForLSD)
    function onNextPage() {
        upBehavior();
        return true;
    }

    function onSwipe(swipeEvent) {
        if (swipeEvent.getDirection() == WatchUi.SWIPE_UP) {
            upBehavior();
        }
    }

    private function upBehavior() {
        WatchUi.popView(WatchUi.SLIDE_UP);
    }

    function onBack(){
        return true;
    }
}