using Toybox.WatchUi;

class FWPreStartMenuDelegate extends WatchUi.BehaviorDelegate{
    function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    public function onSelect(){
        
        FieldWorkView.getInstance().startFieldWork(lastLocation);
        WatchUi.switchToView(FieldWorkView.getInstance(), new FieldWorkDelegate(), WatchUi.SLIDE_RIGHT);
        
    }
}