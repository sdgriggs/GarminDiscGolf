using Toybox.WatchUi;

/*
Represents the delegate for the FieldWork lap menu for when the tee has 
been selected
*/
class FWPostStartMenuDelegate extends WatchUi.MenuInputDelegate{
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol){
        if (item == :start){
            //Update the throw start when Mark New Start is selected
            FieldWorkView.getInstance().updateThrowStart(lastLocation);
        } else if (item == :throw_loc){
            //Add a throw ending at the current position when Mark Throw is selected
            FieldWorkView.getInstance().addThrow(lastLocation);
        }
    }
}