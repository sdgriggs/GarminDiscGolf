using Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;



class ScoreCardView extends WatchUi.View{
    private static const PAGE_BAR_TIME_UP = 1000; 
    private var hole;
    private var inRound;
    private var parList;
    private var strokesList;
    private var manager;
    private var page;
    private var numPages;
    private var showPageBar;
    private var timer;
    function initialize(parList, strokesList){
        self.parList = parList;
        self.strokesList = strokesList;
        page = 0;
        showPageBar = true;
        timer = new Timer.Timer();
        manager = RoundView.getInstance().getManager();
        if(manager != null){
            inRound = true;
            numPages = RoundView.getInstance().getPages();
        } else {
            inRound = false;
            numPages = 1 + (parList.size() - 1) / 9;
        }        
        WatchUi.View.initialize();
    }
    //update hole when the view returns to focus
    function onShow() {
        timer.start(method(:timerCallback), PAGE_BAR_TIME_UP, false);
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

    function onHide() {
        timer.stop();
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
    //the method that the timer will call to hide the progress bar
    function timerCallback() {
        showPageBar = false;
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
        if (showPageBar) {
            GraphicsUtil.showPageBar(dc, numPages, page);
        }        
    }
}