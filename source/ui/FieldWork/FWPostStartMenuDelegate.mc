using Toybox.WatchUi;

class FWPostStartMenuDelegate extends WatchUi.MenuInputDelegate{
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol){
        if (item == :start){
            FieldWorkView.getInstance().updateThrowStart(lastLocation);
        } else if (item == :throw_loc){
            FieldWorkView.getInstance().addThrow(lastLocation);
        }
    }
}