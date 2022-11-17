using Toybox.WatchUi;

/*
The Delegate for the end of Round stat Review Page
*/
class RoundReviewDelegate extends WatchUi.BehaviorDelegate{
    private var reviewView;

    public function initialize(view) {
        WatchUi.BehaviorDelegate.initialize();
        reviewView = view;
    }
    (:notForLSD)
    function onNextPage() {
        pageDown();
        return true;
    }
    (:notForLSD)
    function onPreviousPage() {
        pageUp();
        return true;
    }

    function onSwipe(swipeEvent) {
        if (swipeEvent.getDirection() == WatchUi.SWIPE_UP) {
            pageDown();
        } else if (swipeEvent.getDirection() == WatchUi.SWIPE_DOWN) {
            pageUp();
        }
    }
    //Go down a page
    private function pageDown() {
        reviewView.incrementPageNumber();
    }
    //Go up a page
    private function pageUp() {
        reviewView.decrementPageNumber();
    }
    //Go back to the EndScreen Menu
    function onBack(){
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;//override default
    }
}

    