using Toybox.WatchUi;
using Toybox.Application.Properties;

class ChangeUnitsDelegate extends WatchUi.MenuInputDelegate{

    public function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item){
        if (item == :units_feet){
            Properties.setValue("isMetric", false);
        } else if (item == :units_meters){
            Properties.setValue("isMetric", true);
        }
    }
}