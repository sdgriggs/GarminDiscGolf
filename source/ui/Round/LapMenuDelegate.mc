using Toybox.WatchUi;

class LapMenuDelegate extends WatchUi.MenuInputDelegate{
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        var manager = RoundView.getInstance().getManager();
        var holeInfo = manager.getCurrentHoleInfo();
        if (item == :setPar) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            ChangeParDelegate.pushParPicker(holeInfo[1] - 1);
            
        } else if (item == :markTee) {
            manager.markTee(lastLocation);
        } else if (item == :markThrow) {
            var throwMenu = new WatchUi.Menu();
            throwMenu.setTitle("Outcome");
            throwMenu.addItem("Fairway", FAIRWAY);
            throwMenu.addItem("Rough", ROUGH);
            throwMenu.addItem("OB", OB);
            throwMenu.addItem("In Basket", IN_BASKET);
            WatchUi.switchToView(throwMenu, new ThrowMenuDelegate(), WatchUi.SLIDE_RIGHT);
        } else if (item == :changePar) {
            var changeParMenu = new WatchUi.Menu();
            for (var i = 0; i < holeInfo[1] -1; i++){
                changeParMenu.addItem("Hole " + (i + 1), i);
            }

            if (holeInfo[2] != null) {
                changeParMenu.addItem("Hole " + holeInfo[1], holeInfo[1] - 1);
            }
            WatchUi.switchToView(changeParMenu, new ChangeParDelegate(), WatchUi.SLIDE_RIGHT);
        } else if (item == :undo) {
            manager.undo();
        }
    }
}