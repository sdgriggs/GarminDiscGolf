using Toybox.WatchUi;

class MainMenuView extends WatchUi.Menu{
    public function initialize(){
        WatchUi.Menu.initialize();
        //setTitle("Garmin Disc Golf");
       // addItem("Play Round", :round);
        addItem("Field Work", :fw);
        addItem("Settings", :settings);
    }

    function onShow(){
        System.println("menu");
    }


}