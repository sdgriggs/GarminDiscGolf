using Toybox.WatchUi;

class RoundReviewDelegate extends WatchUi.BehaviorDelegate{
    private var reviewView;

    public function initialize(view) {
        WatchUi.BehaviorDelegate.initialize();
        reviewView = view;
    }
    (:notForLSD)
    function onNextPage() {
        downBehavior();
        return true;
    }
    (:notForLSD)
    function onPreviousPage() {
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
        reviewView.decrementPageNumber();
    }

    private function downBehavior() {
        reviewView.incrementPageNumber();
    }
    function onBack(){
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;//override default
    }
}

    