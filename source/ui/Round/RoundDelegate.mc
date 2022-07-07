using Toybox.WatchUi;

class RoundDelegate extends WatchUi.BehaviorDelegate{

    public function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    public function onSelect(){
        var pauseMenu = new WatchUi.Menu();
        pauseMenu.addItem("Resume", :resume);
        pauseMenu.addItem("Save", :save);
        pauseMenu.addItem("Discard", :discard);

        WatchUi.pushView(pauseMenu, new RoundPauseDelegate(), WatchUi.SLIDE_RIGHT);
    }

    public function onPreviousPage () {
        WatchUi.pushView(new ScoreCardView(), new ScoreCardDelegate(), WatchUi.SLIDE_UP);
    }

    public function onBack(){
            lapBehavior();
            return true;//back behavior is handled, override default
    }

    public function onSwipe(swipeEvent){
        if (swipeEvent.getDirection() == WatchUi.SWIPE_RIGHT){
            lapBehavior();
        }
    }

    private function lapBehavior(){
            if (locationAcquired) {
                var manager = RoundView.getInstance().getManager();
                var holeInfo = manager.getCurrentHoleInfo();
                var menu = new WatchUi.Menu();
                if (manager.needsInitializing()) {
                    menu.addItem("Set Par", :setPar);
                }
                else if (!holeInfo[0]) { //if the tee hasn't been marked
                    menu.addItem("Mark Tee", :markTee);
                }
                else {
                    menu.addItem("Mark Throw", :markThrow);
                }

                if (holeInfo[1] > 1 || !manager.needsInitializing()){//If at least hole 1 has its par marked
                    menu.addItem("Change A Par", :changePar);
                    menu.addItem("Undo", :undo);
                }
                WatchUi.pushView(menu, new LapMenuDelegate(),WatchUi.SLIDE_RIGHT);
                
            }
    }


}