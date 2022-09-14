using Toybox.WatchUi;
using Toybox.Graphics;

class SettingsView extends WatchUi.Menu{

    private var tempText;

    function initialize(){
        WatchUi.Menu.initialize();
        addItem("Units", :set_units);
        addItem("Round Type", :change_round_type);
    }

}
