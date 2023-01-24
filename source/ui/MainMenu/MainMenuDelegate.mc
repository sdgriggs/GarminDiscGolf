import Toybox.WatchUi;

/*
The delegate for the Main Menu
*/
class MainMenuDelegate extends WatchUi.MenuInputDelegate {
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item){
        if (item == :round){ //Start a round
            var title = new WatchUi.Text({
                :text=>"# Of Holes?",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            });
            var numberOfHolesPicker = new WatchUi.Picker({
                :title=>title,
                :pattern=>[new RangePickerFactory(1,100,1)],
                :defaults=>[17]
            });
            WatchUi.pushView(numberOfHolesPicker, new NumHolesPickerDelegate(), WatchUi.SLIDE_IMMEDIATE);
        } else if (item == :fw){//Start a FieldWork Session
            WatchUi.pushView(FieldWorkView.getInstance(), new FieldWorkDelegate(), WatchUi.SLIDE_RIGHT);
        } else if (item == :settings){//Goto the Settings
            var settingsMenu = new WatchUi.Menu();
            settingsMenu.addItem("Units", :set_units);
            settingsMenu.addItem("Round Type", :change_round_type);
            WatchUi.pushView(settingsMenu, new SettingsDelegate(), WatchUi.SLIDE_RIGHT);

        }

    }

}