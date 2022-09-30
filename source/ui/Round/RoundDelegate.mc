using Toybox.WatchUi;
using Stats;

class RoundDelegate extends AbstractRoundDelegate {

    public function initialize(){
        AbstractRoundDelegate.initialize(false);
    }

    //Not for lateral swipe devices
    (:notForLSD)
    public function onPreviousPage () {
        downBehavior();
        return true;
    }

    public function onSwipe(swipeEvent) {
        AbstractRoundDelegate.onSwipe(swipeEvent);
        if (swipeEvent.getDirection() == WatchUi.SWIPE_DOWN) {
            downBehavior();
        }
    }

    private function downBehavior() {
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
}