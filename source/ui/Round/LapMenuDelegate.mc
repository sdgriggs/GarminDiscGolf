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
        } else if (item == :setStrokes) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            ChangeStrokesDelegate.pushStrokePicker(holeInfo[1] - 1);
        }else if (item == :markTee) {
            manager.markTee(lastLocation);
        } else if (item == :markThrow) {
            var throwMenu = new WatchUi.Menu();
            throwMenu.setTitle("Outcome");
            throwMenu.addItem("Fairway", FAIRWAY);
            throwMenu.addItem("Rough", ROUGH);
            throwMenu.addItem("OB", OB);
            throwMenu.addItem("In Basket", IN_BASKET);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.pushView(throwMenu, new ThrowMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
        } else if (item == :changePar) {
            var changeParMenu = new WatchUi.Menu();
            var hole = holeInfo[1] -1;
            if (holeInfo[2] != null) {
                hole++;
            }
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            if (hole > 9) {
                HolesMenu.holesMenusMenu(1, hole, 9, new ChangeParDelegate());
            } else {
                HolesMenu.holesMenu(1, hole, new ChangeParDelegate());
            }
        } else if (item == :changeStrokes) {
            var hole = holeInfo[1] -1;
            if (holeInfo[2] != null) {
                hole++;
            }
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            if (hole > 9) {
                HolesMenu.holesMenusMenu(1, hole, 9, new ChangeStrokesDelegate());
            } else {
                HolesMenu.holesMenu(1, hole, new ChangeStrokesDelegate());
            }           
        }else if (item == :undo) {
            manager.undo();
            if (holeInfo[1] > manager.getCurrentHoleInfo()[1]) {
                RoundView.getInstance().undoneLaps++;
            }
        }
    }
}