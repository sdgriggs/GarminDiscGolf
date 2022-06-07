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
            System.println("In On Back");
            lapBehavior();
            return true;//back behavior is handled, override default
    }

    public function onSwipe(swipeEvent){
        System.println("In On Swipe");
        if (swipeEvent.getDirection() == WatchUi.SWIPE_RIGHT){
            lapBehavior();
        }
    }

    private function lapBehavior(){
            System.println("In Lap Behavior");
            if (locationAcquired) {
                System.println("Hi");
                if (FieldWorkView.getInstance().wasStarted()){
                    WatchUi.pushView(new FWPostStartMenuView(), new FWPostStartMenuDelegate(), WatchUi.SLIDE_RIGHT);
                } else{
                    WatchUi.pushView(new FWPreStartMenuView(), new FWPreStartMenuDelegate(), WatchUi.SLIDE_RIGHT);
                }
                
            }
    }
}