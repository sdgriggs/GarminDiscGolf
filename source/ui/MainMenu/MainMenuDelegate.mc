import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.MenuInputDelegate {
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item){
        if (item == :round){
            System.println("Play Round");
            WatchUi.pushView(new RoundView(), new RoundDelegate(), WatchUi.SLIDE_RIGHT);
        } else if (item == :fw){
            System.println("Field Work");
            FieldWorkView.getInstance().reset();
            WatchUi.pushView(FieldWorkView.getInstance(), new FieldWorkDelegate(), WatchUi.SLIDE_RIGHT);
        } else if (item == :settings){
            System.println("Settings");
            WatchUi.pushView(new SettingsView(), new SettingsDelegate(), WatchUi.SLIDE_RIGHT);

        }

    }
}