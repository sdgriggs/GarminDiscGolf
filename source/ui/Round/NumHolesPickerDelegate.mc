using Toybox.WatchUi;

class NumHolesPickerDelegate extends WatchUi.PickerDelegate {
    function initialize() {
        WatchUi.PickerDelegate.initialize();
    }

    function onAccept(values){
        RoundView.getInstance().setHoles(values[0]);
        WatchUi.switchToView(RoundView.getInstance(), new RoundDelegate(), WatchUi.SLIDE_RIGHT);
    }

    function onCancel(){
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }
}