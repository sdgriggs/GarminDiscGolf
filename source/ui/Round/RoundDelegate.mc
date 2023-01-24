using Toybox.WatchUi;
using Stats;

class RoundDelegate extends AbstractRoundDelegate {

    public function initialize(){
        AbstractRoundDelegate.initialize(false);
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
        WatchUi.pushView(new ScoreCardView(pars, strokes), new ScoreCardDelegate(), WatchUi.SLIDE_DOWN);
    }

    private function pageDown() {
        WatchUi.pushView(new ClockView(2, RoundView.getInstance().getPages()), new ClockRoundDelegate(), WatchUi.SLIDE_UP);
    }
}