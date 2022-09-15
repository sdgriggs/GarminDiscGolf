using Toybox.WatchUi;

class ScoreCardEndDelegate extends WatchUi.BehaviorDelegate{
    var view;
    function initialize(view){
        WatchUi.BehaviorDelegate.initialize();
        self.view = view;
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_UP);
        return true;
    }
    (:notForLSD)
    function onNextPage(){
        downBehavior();
        return true;
    }
    (:notForLSD)
    function onPreviousPage(){
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
        if (view.getHole() < Stats.getHolesCompleted(view.getStrokes())){
            view.setHole(view.getHole() + 9);
        } 
    }

    private function downBehavior() {
        if (view.getHole() > 8 && view.getHole() -  9 >= 0){
            view.setHole(view.getHole() - 9);
        }
    }
}