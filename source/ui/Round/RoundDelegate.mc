using Toybox.WatchUi;
using Stats;

class RoundDelegate extends WatchUi.BehaviorDelegate{

    public function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }

    public function onSelect(){
        var manager = RoundView.getInstance().getManager();
        var holeInfo = manager.getCurrentHoleInfo();

        var pauseMenu = new WatchUi.Menu();
        pauseMenu.addItem("Resume", :resume);
        //if (Stats.getHolesCompleted(manager.getHoles())){
        if (holeInfo[1] > 1) {
            pauseMenu.addItem("Save", :save);
        }
        pauseMenu.addItem("Discard", :discard);

        WatchUi.pushView(pauseMenu, new RoundPauseDelegate(), WatchUi.SLIDE_RIGHT);
    }
    //Not for lateral swipe devices
    (:notForLSD)
    public function onPreviousPage () {
        downBehavior();
        return true;
    }

    public function onBack(){
            lapBehavior();
            return true;//back behavior is handled, override default
    }

    public function onSwipe(swipeEvent) {
        if (swipeEvent.getDirection() == WatchUi.SWIPE_RIGHT){
            lapBehavior();
        } else if (swipeEvent.getDirection() == WatchUi.SWIPE_DOWN) {
            downBehavior();
        }
    }

    private function downBehavior() {
        WatchUi.pushView(new ScoreCardView(null), new ScoreCardDelegate(), WatchUi.SLIDE_DOWN);
    }

    private function lapBehavior() {
            if (locationAcquired) {
                var manager = RoundView.getInstance().getManager();
                var holeInfo = manager.getCurrentHoleInfo();
                var menu = new WatchUi.Menu();
                var simple = manager instanceof SimpleRound;
                if (manager.needsInitializing()) { //if the current hole doesn't have a par yet present set par
                    menu.addItem("Set Par", :setPar);
                }
                else if (!holeInfo[0]) { //if the tee hasn't been marked present mark tee
                    menu.addItem("Mark Tee", :markTee);
                }
                else if (!manager.isCompleted()){ //otherwise present mark throw as long as the round is still in progress
                    if (simple) {
                        menu.addItem("Set Strokes", :setStrokes);
                    } else {
                       menu.addItem("Mark Throw", :markThrow);
                    }
                }

                if (holeInfo[1] > 1){//If at least hole 1 has its par marked
                    menu.addItem("Change A Par", :changePar);
                    if (simple) {
                        menu.addItem("Change A Score", :changeStrokes);
                    } else {
                        menu.addItem("Undo", :undo);
                    }
                } else if (!manager.needsInitializing()) {
                    menu.addItem("Change A Par", :changePar);                  
                    if (!simple) {
                        menu.addItem("Undo", :undo);
                    }
                }
                WatchUi.pushView(menu, new LapMenuDelegate(),WatchUi.SLIDE_RIGHT);
                
            }
    }


}