using Toybox.WatchUi;

class FWPostStartMenuView extends WatchUi.Menu{
    function initialize(){
        WatchUi.Menu.initialize();
        addItem("Mark Throw", :throw_loc);
        addItem("Mark New Start", :start);
        
    }
}