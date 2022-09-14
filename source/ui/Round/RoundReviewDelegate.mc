using Toybox.WatchUi;

class RoundReviewDelegate extends WatchUi.BehaviorDelegate{
    private var reviewView;

    public function initialize(view) {
        WatchUi.BehaviorDelegate.initialize();
        reviewView = view;
    }
    (:notForLSD)
    function onNextPage() {
        upBehavior();
        return true;
    }
    (:notForLSD)
    function onPreviousPage() {
        downBehavior();
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
        reviewView.incrementPageNumber();
    }

    private function downBehavior() {
        reviewView.decrementPageNumber();
    }
    function onBack(){
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;//override default
    }
}

    