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
    //Whether or not the base view needs an extra pop on save, useful when saving from scorecard
    private var popOnSave;
    public function initialize(popOnSave) {
        RoundView.getInstance().getSession().stop();
        WatchUi.MenuInputDelegate.initialize();
        self.popOnSave = popOnSave;

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
            var summaryStatsArr;
            var methodArrs;
            var manager = RoundView.getInstance().getManager();
            if (manager instanceof Round) {
                summaryStatsArr = ["Dist Walked: ",
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
                                //Now get the holes for the fun part
                var holeArray = RoundView.getInstance().getManager().getHoles();

                methodArrs = [[new Lang.Method(Stats, :getCourseDistance), holeArray, FitContributor.DATA_TYPE_STRING, " " +unitName, false], 
                    [new Lang.Method(Stats, :getCombinedPar), holeArray, FitContributor.DATA_TYPE_FLOAT, "", false], 
                    [new Lang.Method(Stats, :getTotalStrokes), holeArray, FitContributor.DATA_TYPE_FLOAT, "", false], 
                    [new Lang.Method(Stats, :getTotalScoreAsString), holeArray, FitContributor.DATA_TYPE_STRING, "", false], 
                    [new Lang.Method(Stats, :getBirdieRate), holeArray, FitContributor.DATA_TYPE_STRING, "", true], 
                    [new Lang.Method(Stats, :getFairwayHits), holeArray, FitContributor.DATA_TYPE_STRING, "", true], 
                    [new Lang.Method(Stats, :getC1), holeArray, FitContributor.DATA_TYPE_STRING, "", true], 
                    [new Lang.Method(Stats, :getC2), holeArray, FitContributor.DATA_TYPE_STRING, "", true], 
                    [new Lang.Method(Stats, :getScramble), holeArray, FitContributor.DATA_TYPE_STRING, "", true], 
                    [new Lang.Method(Stats, :getObThrows), holeArray, FitContributor.DATA_TYPE_FLOAT, "", false], 
                    [new Lang.Method(Stats, :getC1Putting), holeArray, FitContributor.DATA_TYPE_STRING, "", true], 
                    [new Lang.Method(Stats, :getC2Putting), holeArray, FitContributor.DATA_TYPE_STRING, "", true], 
                    [new Lang.Method(Stats, :getAverageThrowIn), holeArray, FitContributor.DATA_TYPE_STRING, " " + unitName, false], 
                    [new Lang.Method(Stats, :getLongestThrowIn), holeArray, FitContributor.DATA_TYPE_STRING, " " + unitName, false]];
            } else {
                var args = {
                    :pars => manager.getPars(),
                    :strokes => manager.getStrokes()
                };
                summaryStatsArr = ["Dist Walked: ",
                    "Time: ",
                    "Calories: ",
                    "Avg. HR: ",
                    "Course Par: ",
                    "Strokes: ",
                    "Score: ",
                    "Birdie Percentage: "];

                    
                methodArrs = [ null,
                    [new Lang.Method(Stats, :getCombinedPar), args, FitContributor.DATA_TYPE_FLOAT, "", false], 
                    [new Lang.Method(Stats, :getTotalStrokes), args, FitContributor.DATA_TYPE_FLOAT, "", false], 
                    [new Lang.Method(Stats, :getTotalScoreAsString), args, FitContributor.DATA_TYPE_STRING, "", false], 
                    [new Lang.Method(Stats, :getBirdieRate), args, FitContributor.DATA_TYPE_STRING, "", true]];
            }
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

            //Adding general round overview stats
            var diff = summaryStatsArr.size() - methodArrs.size();
            var completedStatsList = [];
            for (var i = 0; i < methodArrs.size(); i++) {
                if (methodArrs[i] == null) {
                    continue;
                }
                summaryStatsArr[i + diff] += Stats.writeRoundStat(completedStatsList, methodArrs[i][0], methodArrs[i][1], session, i, methodArrs[i][2], methodArrs[i][3], methodArrs[i][4]);
                if (methodArrs[i][2] != FitContributor.DATA_TYPE_STRING) {
                    summaryStatsArr[i + diff] += methodArrs[i][3];
                }
            }

            session.save();
            
           //construct menu and switch to it
            var pars;
            var strokes;
            if (manager instanceof Round) {
                var holes = manager.getHoles();
                pars = Stats.getParList(holes);
                strokes = Stats.getStrokeList(holes);
            } else {
                strokes = manager.getStrokes();
                var newSize = Stats.getHolesCompleted(strokes);
                pars = manager.getPars().slice(0, newSize);
                strokes = strokes.slice(0, newSize);
            }
            var roundEndMenu = new WatchUi.Menu();
            roundEndMenu.addItem("Round Stats", :round_stats);
            roundEndMenu.addItem("Scorecard", :scorecard);
            roundEndMenu.addItem("Done", :done);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            if (popOnSave) {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            }
            WatchUi.pushView(roundEndMenu, new RoundEndScreenDelegate(summaryStatsArr, pars, strokes), WatchUi.SLIDE_IMMEDIATE);

            RoundView.getInstance().reset();
        } else if (item == :discard) {
            session.discard();

            if (popOnSave) {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            }
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            RoundView.getInstance().reset();
        } 
    }
}