using Toybox.WatchUi;

class ScoreCardView extends WatchUi.View{

    private var temporaryText;

    function initialize(){
        WatchUi.View.initialize();
        var score = Stats.getCombinedScore(RoundView.getInstance().getManager().getHoles());
        var scoreString = "" + score;
        if (score == 0) {
            scoreString = "E";
        }

        temporaryText = new WatchUi.Text({
            :text=>"Score: " + scoreString,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_SYSTEM_SMALL,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }


    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        GraphicsUtil.showPageBar(dc, 2, 0);
        temporaryText.draw(dc);
    }
}