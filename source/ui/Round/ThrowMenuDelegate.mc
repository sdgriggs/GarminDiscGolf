using Toybox.WatchUi;

class ThrowMenuDelegate extends WatchUi.MenuInputDelegate{
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        var roundView = RoundView.getInstance();
        var manager = roundView.getManager();
        manager.addThrow(lastLocation, item);
        if (item == IN_BASKET && !manager.isCompleted()) {
            if (roundView.undoneLaps > 0) {
                roundView.undoneLaps--;
            }
            else{
                roundView.getSession().addLap();
            }
        }
    }
}