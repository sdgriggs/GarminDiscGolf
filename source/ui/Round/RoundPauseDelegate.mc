using Toybox.WatchUi;
using Stats;
using Toybox.FitContributor;
using Toybox.Activity;
using Toybox.System;
using Toybox.Application.Properties;
using Toybox.Application;
using Toybox.Math;
using Toybox.Lang;


class RoundPauseDelegate extends WatchUi.MenuInputDelegate {

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
            var summaryStatsArr = ["Dist Walked: ",
                "Time: ",
                "Calories: ",
                "Avg. HR: ",
                "Course Dist: ",
                "Course Par: ",
                "Strokes: ",
                "Score: ",
                "Birdie Percentage: ",
                "Fairway Hits: ",
                "C1 in Reg: ",
                "C2 in Reg: ",
                "Scramble: ",
                "OB Throws: ",
                "C1 Putting: ",
                "C2 Putting: ",
                "Avg Throw-In: ",
                "Longest Throw-In: "];//The array with all the summary info
            //Get and add the generic activity data
            var activityInfo = Activity.getActivityInfo();
            var distWalkMet = activityInfo.elapsedDistance;
            var distWalkStr = "";
            if (unitName == "m") {
                distWalkStr += (distWalkMet / 1000).format("%.2f") + " km";
            } else {
                distWalkStr += (distWalkMet / 1609.34).format("%.2f") + " miles";
            }
            summaryStatsArr[0] += + distWalkStr;

            var seconds = activityInfo.elapsedTime / 1000;
            var timeStr = "";
            for (var i = 2; i >= 0; i--) {
                var magicNum = Math.pow(60, i).toNumber();
                var tempStr = "" + (seconds / magicNum);
                seconds %= magicNum;
                if (tempStr.length() == 1) {
                    tempStr = "0" + tempStr;
                }
                timeStr += tempStr;
                
                if (i > 0) {
                    timeStr += ":";
                }
            }

            summaryStatsArr[1] += timeStr;

            summaryStatsArr[2] += activityInfo.calories.toString();
            summaryStatsArr[3] += activityInfo.averageHeartRate + " bpm";
            //Now get the holes for the fun part
            var holeArray = RoundView.getInstance().getManager().getHoles();

            var methodArrs = [[new Lang.Method(Stats, :getCourseDistance), FitContributor.DATA_TYPE_STRING, unitName, false], 
                [new Lang.Method(Stats, :getCombinedPar), FitContributor.DATA_TYPE_FLOAT, "", false], 
                [new Lang.Method(Stats, :getTotalStrokes), FitContributor.DATA_TYPE_FLOAT, "", false], 
                [new Lang.Method(Stats, :getTotalScoreAsString), FitContributor.DATA_TYPE_STRING, "", false], 
                [new Lang.Method(Stats, :getBirdieRate), FitContributor.DATA_TYPE_STRING, "", true], 
                [new Lang.Method(Stats, :getFairwayHits), FitContributor.DATA_TYPE_STRING, "", true], 
                [new Lang.Method(Stats, :getC1), FitContributor.DATA_TYPE_STRING, "", true], 
                [new Lang.Method(Stats, :getC2), FitContributor.DATA_TYPE_STRING, "", true], 
                [new Lang.Method(Stats, :getScramble), FitContributor.DATA_TYPE_STRING, "", true], 
                [new Lang.Method(Stats, :getObThrows), FitContributor.DATA_TYPE_FLOAT, "", false], 
                [new Lang.Method(Stats, :getC1Putting), FitContributor.DATA_TYPE_STRING, "", true], 
                [new Lang.Method(Stats, :getC2Putting), FitContributor.DATA_TYPE_STRING, "", true], 
                [new Lang.Method(Stats, :getAverageThrowIn), FitContributor.DATA_TYPE_FLOAT, unitName, true], 
                [new Lang.Method(Stats, :getLongestThrowIn), FitContributor.DATA_TYPE_FLOAT, unitName, true]];

            //Adding general round overview stats
            var diff = summaryStatsArr.size() - methodArrs.size();
            var completedStatsList = new ArrayList();
            for (var i = 0; i < methodArrs.size(); i++) {
                summaryStatsArr[i + diff] += Stats.writeRoundStat(completedStatsList, methodArrs[i][0], holeArray, session, i, methodArrs[i][1], methodArrs[i][2], methodArrs[i][3]) + " " + methodArrs[i][2];
            }

            session.save();
            
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