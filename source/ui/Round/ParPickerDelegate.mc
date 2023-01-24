using Toybox.WatchUi;
using Toybox.Lang;

class ParPickerDelegate extends WatchUi.PickerDelegate {
    private var holeIdx;
    function initialize(holeIdx) {
        if (holeIdx >= 0) {
            self.holeIdx = holeIdx;
        } else {
            throw new Lang.Exception();
        }
        WatchUi.PickerDelegate.initialize();
    }

    function onAccept(values){
        RoundView.getInstance().getManager().setPar(holeIdx, values[0]);
        WatchUi.popView(WatchUi.SLIDE_LEFT);

    }

    function onCancel(){
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }    
}