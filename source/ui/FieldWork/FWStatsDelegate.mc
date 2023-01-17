import Toybox.WatchUi;

class FWStatsDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        WatchUi.BehaviorDelegate.initialize();
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_UP);
        return true;    
    }

    function onSwipe(swipeEvent) {
        if (swipeEvent.getDirection() == WatchUi.SWIPE_RIGHT) {
            //go back on a right swipe if right swipe is not the default back method
            WatchUi.popView(WatchUi.SLIDE_UP);     
        }
    }
}