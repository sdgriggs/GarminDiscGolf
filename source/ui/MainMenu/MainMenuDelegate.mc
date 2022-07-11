import Toybox.WatchUi;


class MainMenuDelegate extends WatchUi.MenuInputDelegate {
    function initialize(){
        WatchUi.MenuInputDelegate.initialize();
    }

    function onMenuItem(item){
        if (item == :round){
            System.println("Play Round");
            //WatchUi.pushView(new RoundView(), new RoundDelegate(), WatchUi.SLIDE_RIGHT);
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
            WatchUi.pushView(numberOfHolesPicker, new NumHolesPickerDelegate(), WatchUi.SLIDE_RIGHT);
        } else if (item == :fw){
            System.println("Field Work");
            WatchUi.pushView(FieldWorkView.getInstance(), new FieldWorkDelegate(), WatchUi.SLIDE_RIGHT);
        } else if (item == :settings){
            System.println("Settings");
            WatchUi.pushView(new SettingsView(), new SettingsDelegate(), WatchUi.SLIDE_RIGHT);

        }

    }

}