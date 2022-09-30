using Toybox.WatchUi;

class ScoreCardDelegate extends AbstractRoundDelegate{
    function initialize() {
        AbstractRoundDelegate.initialize(true);
    }
    //Not for lateral swipe devices
    (:notForLSD)
    function onNextPage() {
        upBehavior();
        return true;
    }

    function onSwipe(swipeEvent) {
        AbstractRoundDelegate.onSwipe(swipeEvent);
        if (swipeEvent.getDirection() == WatchUi.SWIPE_UP) {
            upBehavior();
        }
    }

    private function upBehavior() {
        WatchUi.popView(WatchUi.SLIDE_UP);
    }
}