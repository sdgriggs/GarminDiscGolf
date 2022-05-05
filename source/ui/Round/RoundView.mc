using Toybox.WatchUi;
using Toybox.Graphics;

class RoundView extends WatchUi.View{
    private var tempText;

    function initialize(){
        WatchUi.View.initialize();
    }

    function onShow(){
        tempText = new WatchUi.Text({
            :text=>"Not Yet Implemented",
            :color=>Graphics.COLOR_RED,
            :font=>Graphics.FONT_MEDIUM,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }

    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        tempText.draw(dc);
    }

}
