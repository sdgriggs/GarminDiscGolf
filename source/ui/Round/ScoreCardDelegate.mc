using Toybox.WatchUi;

class ScoreCardDelegate extends WatchUi.BehaviorDelegate{
    function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    function onNextPage() {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
    function onBack(){
        return true;
    }
}