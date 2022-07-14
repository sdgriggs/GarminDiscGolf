using Toybox.WatchUi;

class ThrowMenuDelegate extends WatchUi.MenuInputDelegate{
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        var roundView = RoundView.getInstance();
        roundView.getManager().addThrow(lastLocation, item);
        if (item == IN_BASKET) {
            if (roundView.undoneLaps > 0) {
                roundView.undoneLaps--;
            }
            else{
                roundView.getSession().addLap();
            }
        }
    }
}