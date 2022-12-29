using Toybox.WatchUi;

class ClockRoundDelegate extends WatchUi.BehaviorDelegate {

    public function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    //Not for lateral swipe devices
    (:notForLSD)
    public function onPreviousPage () {
        pageUp();
        return true;
    }

    //Not for lateral swipe devices
    (:notForLSD)
    public function onNextPage () {
        pageDown();
        return true;
    }

    public function onSwipe(swipeEvent) {
        AbstractRoundDelegate.onSwipe(swipeEvent);
        if (swipeEvent.getDirection() == WatchUi.SWIPE_DOWN) {
            pageUp();
        }
        else if (swipeEvent.getDirection() == WatchUi.SWIPE_UP) {
            pageDown();
        }
    }

    private function pageUp() {
        popView(WatchUi.SLIDE_DOWN);
    }

    private function pageDown() {
        var manager = RoundView.getInstance().getManager();
        var pars;
        var strokes;
        if (manager instanceof Round) {
            var holes = manager.getHoles();
            pars = Stats.getParList(holes);
            strokes = Stats.getStrokeList(holes);
        } else {
            pars = manager.getPars();
            strokes = manager.getStrokes();
        }
        WatchUi.switchToView(new ScoreCardView(pars, strokes), new ScoreCardDelegate(), WatchUi.SLIDE_UP);
    }
}