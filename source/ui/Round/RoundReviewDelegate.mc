using Toybox.WatchUi;

class RoundReviewDelegate extends WatchUi.BehaviorDelegate{
    private var reviewView;

    public function initialize(view) {
        WatchUi.BehaviorDelegate.initialize();
        reviewView = view;
    }

    function onNextPage() {
        reviewView.incrementPageNumber();
    }

    function onPreviousPage() {
        reviewView.decrementPageNumber();
    }
    function onBack(){
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;//override default
    }
}

    