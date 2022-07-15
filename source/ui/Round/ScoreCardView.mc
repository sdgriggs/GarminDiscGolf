using Toybox.WatchUi;
using Toybox.System;

class ScoreCardView extends WatchUi.View{


    function initialize(){
        WatchUi.View.initialize();
    }


    function onUpdate(dc) { 
        var manager = RoundView.getInstance().getManager();
        var hole = manager.getCurrentHoleInfo()[1];
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        GraphicsUtil.showPageBar(dc, 2, 0);
        GraphicsUtil.drawScoreCard(dc, hole, manager.getHoles());
        
    }
}