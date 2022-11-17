using Toybox.WatchUi;
/*
The Delegate for the in Round Score Card
*/
class ScoreCardDelegate extends AbstractRoundDelegate{
    function initialize() {
        AbstractRoundDelegate.initialize(true);
    }
    //Not for lateral swipe devices
    (:notForLSD)
    function onNextPage() {
        pageDown();
        return true;
    }

    function onSwipe(swipeEvent) {
        AbstractRoundDelegate.onSwipe(swipeEvent);
        if (swipeEvent.getDirection() == WatchUi.SWIPE_UP) {
            pageDown();
        }
    }
    //Go down a page back to the main view
    private function pageDown() {
        WatchUi.popView(WatchUi.SLIDE_UP);
    }
}