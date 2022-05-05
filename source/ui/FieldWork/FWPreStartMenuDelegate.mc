using Toybox.WatchUi;

class FWPreStartMenuDelegate extends WatchUi.MenuInputDelegate{
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item){
        if (item == :start){
            FieldWorkView.getInstance().startFieldWork(lastLocation);
        }
    }
}