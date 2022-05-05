using Toybox.WatchUi;
using Toybox.Graphics;

class ChangeUnitsView extends WatchUi.Menu{

    private var tempText;

    function initialize(){
        WatchUi.Menu.initialize();
        addItem("Feet", :units_feet);
        addItem("Meters", :units_meters);
    }

}
