using Toybox.WatchUi;

class SettingsDelegate extends WatchUi.MenuInputDelegate{

    public function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item){
        if (item == :set_units){
            var menu = new WatchUi.Menu();
            menu.addItem("Feet", :units_feet);
            menu.addItem("Meters", :units_meters);
            WatchUi.pushView(menu, new ChangeUnitsDelegate(), WatchUi.SLIDE_RIGHT);
        } else if (item == :change_round_type) {
            var menu = new WatchUi.Menu();
            menu.addItem("Scores Only", :simple);
            menu.addItem("Full Stats", :advanced);
            WatchUi.pushView(menu, new ChangeRoundTypeDelegate(), WatchUi.SLIDE_RIGHT);
        }
    }
}