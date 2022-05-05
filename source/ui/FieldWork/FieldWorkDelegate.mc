using Toybox.WatchUi;

class FieldWorkDelegate extends WatchUi.BehaviorDelegate{

    public function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    public function onSelect(){
        System.println("Going to pause menu");
        WatchUi.pushView(new FWPauseMenuView(), new FWPauseMenuDelegate(), WatchUi.SLIDE_RIGHT);
    }

    public function onBack(){
        System.println("Hi");
        if (FieldWorkView.getInstance().wasStarted()){
            WatchUi.pushView(new FWPostStartMenuView(), new FWPostStartMenuDelegate(), WatchUi.SLIDE_RIGHT);
        } else{
            WatchUi.pushView(new FWPreStartMenuView(), new FWPreStartMenuDelegate(), WatchUi.SLIDE_RIGHT);
        }
        return true;//back behavior is handled, override default
    }
}