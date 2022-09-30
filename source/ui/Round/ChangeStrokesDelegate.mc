using Toybox.WatchUi;
using Toybox.Graphics;

class ChangeStrokesDelegate extends WatchUi.MenuInputDelegate{
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        pushStrokePicker(item);
    }

    public static function pushStrokePicker(holeIdx) {
            var title = new WatchUi.Text({
                :text=>"Set Strokes",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            });
            var strokePicker = new WatchUi.Picker({
                :title=>title,
                :pattern=>[new RangePickerFactory(1,20,1)],
                :defaults=>[2]
            });
            WatchUi.pushView(strokePicker, new StrokePickerDelegate(holeIdx), WatchUi.SLIDE_RIGHT);
    }
}