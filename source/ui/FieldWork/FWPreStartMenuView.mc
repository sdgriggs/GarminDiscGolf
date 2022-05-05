using Toybox.WatchUi;

class FWPreStartMenuView extends WatchUi.Menu{
    function initialize(){
        WatchUi.Menu.initialize();
        addItem("Mark Start", :start);
    }
}