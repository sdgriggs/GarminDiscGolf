using Toybox.WatchUi;

class RoundReviewDelegate extends WatchUi.BehaviorDelegate{
    

    public function initialize() {

        WatchUi.BehaviorDelegate.initialize();
    }

    function onNextPage() {
        if (reviewPageNumber < (1 + completedHoles.size())) {
            reviewPageNumber++;
        }
        //System.print("INC");
    }

    function onPreviousPage() {

        if (reviewPageNumber > 0) {
            reviewPageNumber--;
        }
        //System.print("DEC");
    }
    function onBack(){
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}

    