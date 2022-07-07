using Toybox.WatchUi;

class ScoreCardView extends WatchUi.View{
    function initialize(){
        WatchUi.View.initialize();
    }


    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        GraphicsUtil.showPageBar(dc, 2, 0);
    }
}