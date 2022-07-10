using Toybox.WatchUi;

class RoundPauseDelegate extends WatchUi.MenuInputDelegate {
    public function initialize() {
        RoundView.getInstance().getSession().stop();
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item) {
        if (item == :resume) {
            //Don't do anything
        } else if (item == :save) {
            //
            RoundView.getInstance().getSession().save();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            RoundView.getInstance().reset();
        } else if (item == :discard) {
            RoundView.getInstance().getSession().discard();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            RoundView.getInstance().reset();
        }
    }
}