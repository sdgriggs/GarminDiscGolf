using Toybox.WatchUi;
using Stats;

class AbstractRoundDelegate extends WatchUi.BehaviorDelegate{
    private var popOnSave;
    public function initialize(popOnSave){
        WatchUi.BehaviorDelegate.initialize();
        self.popOnSave = popOnSave;
    }

    public function onSelect(){
        var manager = RoundView.getInstance().getManager();
        var holeInfo = manager.getCurrentHoleInfo();

        var pauseMenu = new WatchUi.Menu();
        pauseMenu.addItem("Resume", :resume);
       
        if (holeInfo[1] > 1 || manager.isCompleted()) {
            pauseMenu.addItem("Save", :save);
        }
        pauseMenu.addItem("Discard", :discard);

        WatchUi.pushView(pauseMenu, new RoundPauseDelegate(popOnSave), WatchUi.SLIDE_RIGHT);
    }

    public function onBack(){
            lapBehavior();
            return true;//back behavior is handled, override default
    }

    public function onSwipe(swipeEvent) {
        if (swipeEvent.getDirection() == WatchUi.SWIPE_RIGHT){
            lapBehavior();
        }
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