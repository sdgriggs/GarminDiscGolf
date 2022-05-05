using Toybox.WatchUi;

class SettingsDelegate extends WatchUi.MenuInputDelegate{

    public function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item){
        if (item == :set_units){
            WatchUi.pushView(new ChangeUnitsView(), new ChangeUnitsDelegate(), WatchUi.SLIDE_RIGHT);
        }
    }
}