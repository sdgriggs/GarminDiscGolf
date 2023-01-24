using Toybox.WatchUi;
using Toybox.Lang;

class StrokePickerDelegate extends WatchUi.PickerDelegate {
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
        RoundView.getInstance().getManager().setStrokes(holeIdx, values[0]);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

    }

    function onCancel(){
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }    
}