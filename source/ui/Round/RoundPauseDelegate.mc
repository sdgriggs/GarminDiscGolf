using Toybox.WatchUi;

class RoundPauseDelegate extends WatchUi.MenuInputDelegate {
    public function initialize() {
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item) {
        if (item == :resume) {
            //Don't do anything
        } else if (item == :save) {
            //add in saving and stats view
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            RoundView.getInstance().reset();
        } else if (item == :discard) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            RoundView.getInstance().reset();
        }
    }
}