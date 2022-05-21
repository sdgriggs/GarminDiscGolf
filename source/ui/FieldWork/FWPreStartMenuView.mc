using Toybox.WatchUi;
using Toybox.Position;

class FWPreStartMenuView extends WatchUi.Menu{
    private var quality;
    private static const signalNames = {
        Position.QUALITY_NOT_AVAILABLE => "None",
        Position.QUALITY_POOR => "Poor",
        Position.QUALITY_USABLE => "Moderate",
        Position.QUALITY_GOOD => "Good"
    };

    function initialize(){
        WatchUi.Menu.initialize();

        self.quality = Position.getInfo().accuracy;
        setTitle("GPS:" + signalNames.get(self.quality));
        addItem("Mark Start", :start);
    }
    function onUpdate(dc){
        var newQuality = Position.getInfo();
        if (newQuality != self.quality){
            self.quality = newQuality;
            setTitle("GPS: " + signalNames.get(self.quality));
        }
        WatchUi.Menu.onUpdate(dc);
    }
}