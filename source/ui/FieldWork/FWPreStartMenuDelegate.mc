using Toybox.WatchUi;

class FWPreStartMenuDelegate extends WatchUi.BehaviorDelegate{
    function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    public function onSelect(){
        
        FieldWorkView.getInstance().startFieldWork(lastLocation);
        WatchUi.popView(WatchUi.SLIDE_LEFT);
        
    }
}