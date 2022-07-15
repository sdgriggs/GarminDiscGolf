using Toybox.WatchUi;
using Stats;
using Toybox.FitContributor;

class RoundPauseDelegate extends WatchUi.MenuInputDelegate {
    private static const SCORE_FIELD_ID = 0;
    public function initialize() {
        RoundView.getInstance().getSession().stop();
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item) {
        var session = RoundView.getInstance().getSession();
        if (item == :resume) {
            //Don't do anything
        } else if (item == :save) {
            var score = Stats.getCombinedScore(RoundView.getInstance().getManager().getHoles());
                    var scoreString = "" ;
            if(score > 0 ){
                scoreString = "+" + score;
            } else if (score < 0) {
                scoreString = "" + score;
            } else {
                scoreString = "E";
            } 
            var totalScoreField = session.createField("Score", SCORE_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>scoreString.length() + 1,
                :units=>""
            });

            totalScoreField.setData(scoreString);
            

            session.save();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            RoundView.getInstance().reset();
        } else if (item == :discard) {
            session.discard();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            RoundView.getInstance().reset();
        }
    }
}