using Toybox.WatchUi;
/*
Represents the delegate for the FieldWork lap menu for when the tee has yet to 
be marked
*/
class FWPreStartMenuDelegate extends WatchUi.BehaviorDelegate{
    function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    public function onSelect(){     
        FieldWorkView.getInstance().startFieldWork(lastLocation);
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }
}