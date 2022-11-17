using Toybox.WatchUi;

/*
The delegate for the main FieldWorkView.
*/
class FieldWorkDelegate extends WatchUi.BehaviorDelegate{

    public function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    //On select push the pause menu
    public function onSelect(){
        var menu = new WatchUi.Menu();
        menu.addItem("Resume", :resume_fw);
        menu.addItem("End Session", :end_fw);
        WatchUi.pushView(menu, new FWPauseMenuDelegate(), WatchUi.SLIDE_RIGHT);
    }

    //On back perform lapBehavior
    public function onBack(){
        lapBehavior();
        return true;//back behavior is handled, override default
    }

    /*
    On swipe right perform lapBehavior (used for some touch screen devices)
    that have non standard onBack() methods
    */
    public function onSwipe(swipeEvent){
        if (swipeEvent.getDirection() == WatchUi.SWIPE_RIGHT){
            lapBehavior();
        }
    }

    //Pushes the appropriate Field Work menu depending on if the FieldWork has been started
    private function lapBehavior(){
            if (locationAcquired) {
                if (FieldWorkView.getInstance().wasStarted()){
                    var menu = new WatchUi.Menu();
                    menu.addItem("Mark Throw", :throw_loc);
                    menu.addItem("Mark New Start", :start);
                    WatchUi.pushView(menu, new FWPostStartMenuDelegate(), WatchUi.SLIDE_RIGHT);
                } else{
                    WatchUi.pushView(new FWPreStartMenuView(), new FWPreStartMenuDelegate(), WatchUi.SLIDE_RIGHT);
                }
                
            }
    }
}