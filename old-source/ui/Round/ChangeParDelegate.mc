using Toybox.WatchUi;
using Toybox.Graphics;

class ChangeParDelegate extends WatchUi.MenuInputDelegate{
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        pushParPicker(item);
    }

    public static function pushParPicker(holeIdx) {
            var title = new WatchUi.Text({
                :text=>"Set Par",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            });
            var parPicker = new WatchUi.Picker({
                :title=>title,
                :pattern=>[new RangePickerFactory(1,10,1)],
                :defaults=>[2]
            });
            WatchUi.pushView(parPicker, new ParPickerDelegate(holeIdx), WatchUi.SLIDE_IMMEDIATE);
    }
}