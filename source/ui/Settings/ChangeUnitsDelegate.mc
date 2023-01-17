using Toybox.WatchUi;
using Toybox.Application.Properties;
using Toybox.Application;
/*
The delegate for the Change Units Menu
*/
class ChangeUnitsDelegate extends WatchUi.MenuInputDelegate{

    public function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item){
        if (item == :units_feet){
            if (Toybox.Application has :Properties){
                Properties.setValue("isMetric", false);
            } else{
                getApp().setProperty("isMetric", false);
            }
        } else if (item == :units_meters){
            if (Toybox.Application has :Properties){
                Properties.setValue("isMetric", true);
            } else {
                getApp().setProperty("isMetric", true);
            }
        }
    }
}