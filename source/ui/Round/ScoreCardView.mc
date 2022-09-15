using Toybox.WatchUi;
using Toybox.System;



class ScoreCardView extends WatchUi.View{
    private var hole;
    private var inRound;
    private var parList;
    private var strokesList;
    function initialize(parList, strokesList){
        self.parList = parList;
        self.strokesList = strokesList;
        var manager = RoundView.getInstance().getManager();
        if(manager != null){
            inRound = true;
            hole = manager.getCurrentHoleInfo()[1];
        } else {
            inRound = false;
            hole = 9;
        }        
        WatchUi.View.initialize();
    }

    function getPars() {
        return parList;
    }

    function getStrokes() {
        return strokesList;
    }

    function getHole() {
        return hole;
    }

    function setHole(hole) {
        self.hole = hole;
    }


    function onUpdate(dc) { 
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        if(inRound) {
            GraphicsUtil.showGPSStatus(dc, gpsQuality);
            GraphicsUtil.showPageBar(dc, 2, 0);
      
            GraphicsUtil.drawScoreCard(dc, hole, parList, strokesList);
        } else{
            GraphicsUtil.showPageBar(dc, 2, 0);
      
            GraphicsUtil.drawScoreCard(dc, hole, parList, strokesList);
    
        }
        
    }
}