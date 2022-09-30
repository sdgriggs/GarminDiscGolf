using Toybox.WatchUi;
using Toybox.System;



class ScoreCardView extends WatchUi.View{
    private var hole;
    private var inRound;
    private var parList;
    private var strokesList;
    private var manager;
    private var page;
    private var numPages;
    function initialize(parList, strokesList){
        self.parList = parList;
        self.strokesList = strokesList;
        page = 0;
        manager = RoundView.getInstance().getManager();
        if(manager != null){
            inRound = true;
            numPages = 2;
        } else {
            inRound = false;
            numPages = 1 + (parList.size() - 1) / 9;
        }        
        WatchUi.View.initialize();
    }
    //update hole when the view returns to focus
    function onShow() {
        if (inRound) {
            //update the list of pars and strokes on show
            hole = manager.getCurrentHoleInfo()[1];
            if (manager instanceof Round) {
                var holes = manager.getHoles();
                parList = Stats.getFullParList(holes);
                strokesList = Stats.getFullStrokeList(holes);
            }
            //resume activity recording after pause
            var session = RoundView.getInstance().getSession();

            if(session != null && !session.isRecording()) {
                session.start();
            }
        }
        else {
            //start with the first 9
            hole = 9;
        }
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
        if (!inRound) {
            page = (hole - 1) / 9;
        }
        WatchUi.requestUpdate();
    }


    function onUpdate(dc) { 
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        if(inRound) {
            GraphicsUtil.showGPSStatus(dc, gpsQuality);
            var inProgress = !manager.isCompleted();
            GraphicsUtil.drawScoreCard(dc, hole, parList, strokesList, inProgress);
        } else{    
            GraphicsUtil.drawScoreCard(dc, hole, parList, strokesList, false);
        }
        System.println(" " + page + "/" + numPages);
        GraphicsUtil.showPageBar(dc, numPages, page);
        
    }
}