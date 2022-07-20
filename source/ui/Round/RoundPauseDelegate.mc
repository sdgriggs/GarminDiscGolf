using Toybox.WatchUi;
using Stats;
using Toybox.FitContributor;
using Toybox.Activity;


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
            var summaryStatsArr = new [14];//The array with all the summary info
            //Get and add the generic activity data
            var activityInfo = Activity.getActivityInfo();
            summaryStatsArr[0] = "Distance Walked: " + activityInfo.elapsedDistance;
            summaryStatsArr[1] = "Time: " + activityInfo.elapsedTime;
            summaryStatsArr[2] = "Calories: " + activityInfo.calories;
            summaryStatsArr[3] = "Avg. HR: " + activityInfo.averageHeartRate;
            //Now get the holes for the fun part
            var holeArray = RoundView.getInstance().getManager().getHoles();

            //Adding general round overview stats
                //Course Distance
            var courseDistance = Stats.getCourseDistance(holeArray);
            summaryStatsArr[4] = "Course Distance: " + courseDistance;
                //Course Par
            var coursePar = Stats.getCoursePar(holeArray);
            summaryStatsArr[5] = "Course Par: " + coursePar;

                //Strokes
            var strokes = Stats.getTotalStrokes(holeArray);
            summaryStatsArr[6] = "Strokes: " + strokes;

                //Score
            var score = Stats.getCombinedScore(holeArray);
            var scoreString = Stats.convertScoreToString(score);
            var totalScoreField = session.createField("Score", SCORE_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>scoreString.length() + 1,
                :units=>""
            });
            totalScoreField.setData(scoreString);
            summaryStatsArr[7] = "Score: " + scoreString;

                //Birdie Percentage
            var birdiePerc = "" + (Math.round(Stats.getBirdieRate(holeArray) * 100).toNumber()) + "%"; //2 decimal places of precision would be cooler
            summaryStatsArr[8] = "Birdie Percentage: " + birdiePerc;
            
            //Adding driving stats

                //Fairway Hits
            var fairwayHits = Stats.getFairwayHits(holeArray);
            summaryStatsArr[9] = "Fairway Hits: " + (fairwayHits * 100).toNumber() + "%";

                //C1 %
            //TODO
            summaryStatsArr[10] = "";

                //C2 %
            //TODO
            summaryStatsArr[11] = "";

                //Scramble Percentage
            var scrambleArr = Stats.getScramble(holeArray);
            System.println(scrambleArr);
            var scramblePerc = "N/A";
            if (scrambleArr[1] != 0) {
                scramblePerc = "" + (Math.round(1.0 * scrambleArr[0]/scrambleArr[1] * 100).toNumber()) + "%";
            }
            summaryStatsArr[12] = "Scramble Percentage: " + scramblePerc;
                //# Of Ob throws
            //TODO
            summaryStatsArr[13] = "";
            //Adding putting stats


            session.save();
           // WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

           //construct menu and switch to it
            var roundEndMenu = new WatchUi.Menu();
            roundEndMenu.addItem("Round Stats", :round_stats);
            roundEndMenu.addItem("Holes", :holes);
            roundEndMenu.addItem("Scorecard", :scorecard);
            roundEndMenu.addItem("Done", :done);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.switchToView(roundEndMenu, new RoundEndScreenDelegate(summaryStatsArr), WatchUi.SLIDE_IMMEDIATE);

            RoundView.getInstance().reset();
        } else if (item == :discard) {
            session.discard();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            RoundView.getInstance().reset();
        }
    }
}