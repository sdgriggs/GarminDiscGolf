using Toybox.WatchUi;
using Toybox.Application.Properties;
using Toybox.Application;
/*
The delegate for the Change Round Type Menu
*/
class ChangeRoundTypeDelegate extends WatchUi.MenuInputDelegate{

    public function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item){
        if (item == :simple){
            if (Toybox.Application has :Properties){
                Properties.setValue("roundIsSimple", true);
            } else{
                getApp().setProperty("roundIsSimple", true);
            }
        } else if (item == :advanced){
            if (Toybox.Application has :Properties){
                Properties.setValue("roundIsSimple", false);
            } else {
                getApp().setProperty("roundIsSimple", false);
            }
        }
    }
}