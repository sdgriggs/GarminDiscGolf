using Toybox.WatchUi;
class HolesMenu {
    //Creates a menu of menus of holes with an inputted number of holes per menu
    //Values of menu items represent the first hole of the range and are 1 indexed
    public static function holesMenusMenu(startHole, endHole, holesPerMenu, menuDelegate) {
        var menu = new WatchUi.Menu();
        for (var i = startHole; i <= endHole; i+= holesPerMenu) {
            var lastInRange = i + holesPerMenu - 1;
            //uncomment to have more specific text ranges for uncompleted 9s
            // if (lastInRange > endHole) {
            //     lastInRange = endHole;
            // }
            menu.addItem("Holes " + i + "-" + lastInRange, i);
        }

        WatchUi.pushView(menu, new HolesMenusMenuDelegate(endHole, holesPerMenu, menuDelegate), WatchUi.SLIDE_IMMEDIATE);

    }
    //Creates a menu of holes from the start hole to the end hole inclusive using the inputted menu delegate
    //Values of menu items represent the hole and are 0 indexed
    public static function holesMenu(startHole, endHole, menuDelegate) {
        var menu = new WatchUi.Menu();
        for (var i = startHole; i <= endHole; i++){
            menu.addItem("Hole " + i, i - 1);
        }
        WatchUi.pushView(menu, menuDelegate, WatchUi.SLIDE_IMMEDIATE);
    }

    static class HolesMenusMenuDelegate extends WatchUi.MenuInputDelegate {
        private var endHole;
        private var holesPerMenu;
        private var menuDelegate;
        public function initialize(endHole, holesPerMenu, menuDelegate) {
            WatchUi.MenuInputDelegate.initialize();
            self.endHole = endHole;
            self.holesPerMenu = holesPerMenu;
            self.menuDelegate = menuDelegate;
        }

        function onMenuItem(item) {
            var last = item + holesPerMenu - 1;
            if (last > endHole) {
                last = endHole;
            }

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            holesMenu(item, last, menuDelegate);

        }
    }
}