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

    //Not for lateral swipe devices
    (:notForLSD)
    function onPreviousPage() {
        pageUp();
        return true;
    }

    function onSwipe(swipeEvent) {
        AbstractRoundDelegate.onSwipe(swipeEvent);
        if (swipeEvent.getDirection() == WatchUi.SWIPE_UP) {
            pageDown();
        }
        else if (swipeEvent.getDirection() == WatchUi.SWIPE_DOWN) {
            pageUp();
        }
    }
    //Go down a page back to the main view
    private function pageDown() {
        WatchUi.popView(WatchUi.SLIDE_UP);
    }

    private function pageUp() {
        WatchUi.switchToView(new ClockView(2, RoundView.getInstance().getPages()), new ClockRoundDelegate(), WatchUi.SLIDE_DOWN);
    }
}