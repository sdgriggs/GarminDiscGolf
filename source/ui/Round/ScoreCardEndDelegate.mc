using Toybox.WatchUi;
/*
The Delegate for the end of Round score card 
*/
class ScoreCardEndDelegate extends WatchUi.BehaviorDelegate{
    private var view;
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
        pageDown();
        return true;
    }
    (:notForLSD)
    function onPreviousPage(){
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
    //Go up a page
    private function pageUp() {
        if (view.getHole() > 9){
            view.setHole(view.getHole() - 9);
        } 
    }
    //Go down a page
    private function pageDown() {       
        if (view.getHole() < Stats.getHolesCompleted(view.getStrokes())){
            view.setHole(view.getHole() + 9);
        } 
    }
}