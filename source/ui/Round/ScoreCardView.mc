using Toybox.WatchUi;
using Toybox.System;

var hole;

class ScoreCardView extends WatchUi.View{

    var inRound;
    var holeArray;
    function initialize(hr){
        if(hr == null){
            inRound = true;
        } else {
            inRound = false;
            holeArray = hr;
            hole = 9;
        }
        
        WatchUi.View.initialize();
    }


    function onUpdate(dc) { 
        var manager = RoundView.getInstance().getManager();
        if(inRound) {
            hole = manager.getCurrentHoleInfo()[1];

            dc.clear();
            GraphicsUtil.showGPSStatus(dc, gpsQuality);
            GraphicsUtil.showPageBar(dc, 2, 0);
      
            GraphicsUtil.drawScoreCard(dc, hole, manager.getHoles());
        } else{
            dc.clear();
            GraphicsUtil.showGPSStatus(dc, gpsQuality);
            GraphicsUtil.showPageBar(dc, 2, 0);
      
            GraphicsUtil.drawScoreCard(dc, hole, holeArray);
    
        }
        
    }
}