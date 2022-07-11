using Toybox.WatchUi;

class ThrowMenuDelegate extends WatchUi.MenuInputDelegate{
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        RoundView.getInstance().getManager().addThrow(lastLocation, item);
        if (item == IN_BASKET) {
            RoundView.getInstance().getSession().addLap();
        }
    }
}