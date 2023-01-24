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
        else if (swipeEvent.getDirection() == WatchUi.SWIPE_RIGHT) {
            //go back on a right swipe if right swipe is not the default back method
            WatchUi.popView(WatchUi.SLIDE_UP);     
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

    