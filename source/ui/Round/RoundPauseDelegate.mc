using Toybox.WatchUi;
using Stats;
using Toybox.FitContributor;
using Toybox.Activity;
using Toybox.System;
using Toybox.Application.Properties;
using Toybox.Application;


class RoundPauseDelegate extends WatchUi.MenuInputDelegate {
    private static const SCORE_FIELD_ID = 0;

    private static const PAR_LAP_FIELD_ID = 14;
    public function initialize() {
        RoundView.getInstance().getSession().stop();
        WatchUi.MenuInputDelegate.initialize();
    }

    public function onMenuItem(item) {

            var unitName = "ft";
            if (Toybox.Application has :Properties && Properties.getValue("isMetric")){
                unitName = "m";
            } else if (getApp().getProperty("isMetric")){
                unitName = "m";
            }

        var session = RoundView.getInstance().getSession();
        if (item == :resume) {
            //Don't do anything
        } else if (item == :save) {
            var summaryStatsArr = new [18];//The array with all the summary info
            //Get and add the generic activity data
            var activityInfo = Activity.getActivityInfo();
            summaryStatsArr[0] = "Dist Walked: " + activityInfo.elapsedDistance.toNumber() + " m";
            summaryStatsArr[1] = "Time: " + activityInfo.elapsedTime / 1000 +" s";
            summaryStatsArr[2] = "Calories: " + activityInfo.calories;
            summaryStatsArr[3] = "Avg. HR: " + activityInfo.averageHeartRate +" bpm";
            //Now get the holes for the fun part
            var holeArray = RoundView.getInstance().getManager().getHoles();

            //Adding general round overview stats
                //Course Distance
            var courseDistance = Stats.getCourseDistance(holeArray);
            summaryStatsArr[4] = "Course Dist: " + courseDistance.toNumber() + " " + unitName;
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
            var c1InReg = Stats.getC1(holeArray);
            summaryStatsArr[10] = "C1 in Reg: " + (c1InReg * 100).toNumber() + "%";

                //C2 %
            //TODO
            var c2InReg = Stats.getC2(holeArray);
            summaryStatsArr[11] = "C2 in Reg: " + (c2InReg * 100).toNumber() + "%";

                //Scramble Percentage
            var scrambleArr = Stats.getScramble(holeArray);
            System.println(scrambleArr);
            var scramblePerc = "N/A";
            if (scrambleArr[1] != 0) {
                scramblePerc = "" + (Math.round(1.0 * scrambleArr[0]/scrambleArr[1] * 100).toNumber()) + "%";
            }
            summaryStatsArr[12] = "Scramble: " + scramblePerc;
   
            var oBthrows = Stats.getObThrows(holeArray);
            summaryStatsArr[13] = "OB Throws: " + oBthrows;
            //putting stats
            var c1Putting  = Stats.getC1Putting(holeArray);
            var c1PuttingPerc = "N/A";
            if (c1Putting[1] != 0) {
                c1PuttingPerc = "" + (Math.round(1.0 * c1Putting[0]/c1Putting[1] * 100).toNumber()) + "%";
            }
            summaryStatsArr[14] = "C1 Putting: " + c1PuttingPerc;

            var c2Putting  = Stats.getC2Putting(holeArray);
            var c2PuttingPerc = "N/A";
            if (c2Putting[1] != 0) {
                c2PuttingPerc = "" + (Math.round(1.0 * c2Putting[0]/c2Putting[1] * 100).toNumber()) + "%";
            }
            summaryStatsArr[15] = "C2 Putting: " + c2PuttingPerc;

            var avgThrowIn = Stats.getAverageThrowIn(holeArray);
            summaryStatsArr[16] = "Avg Throw-In: " + (100 * avgThrowIn).toNumber() + unitName;

            var longestThrowIn = Stats.getLongestThrowIn(holeArray);
            summaryStatsArr[17] = "Longest Throw-In: " + (100 * longestThrowIn).toNumber() + unitName;


            //Laps stuff
            //Par
            var parByLap = Stats.getParList(holeArray);
            System.println(parByLap);
            var parLapField = session.createField("Lap", PAR_LAP_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_LAP,
                :units=>"",
                //:count=>parByLap.size() + 1,
                :count=>2,
            });
            /*
            for (var i = 0; i < parByLap.size(); i++) {
                parLapField.setData(5);
            }
            */
            parLapField.setData("" + 5);
            parLapField.setData("" + 6);
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