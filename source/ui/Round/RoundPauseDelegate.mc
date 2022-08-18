using Toybox.WatchUi;
using Stats;
using Toybox.FitContributor;
using Toybox.Activity;
using Toybox.System;
using Toybox.Application.Properties;
using Toybox.Application;


class RoundPauseDelegate extends WatchUi.MenuInputDelegate {
    private static const COURSE_D_FIELD_ID = 0;
    private static const PAR_FIELD_ID = 1;
    private static const STROKES_FIELD_ID = 2;
    private static const SCORE_FIELD_ID = 3;
    private static const BIRD_PERC_FIELD_ID = 4;
    private static const FAIRWAY_FIELD_ID = 5;
    private static const C1_REG_FIELD_ID = 6;
    private static const C2_REG_FIELD_ID = 7;
    private static const SCRAMBLE_FIELD_ID = 8;
    private static const OB_FIELD_ID = 9;
    private static const C1_PUTT_FIELD_ID = 10;
    private static const C2_PUTT_FIELD_ID = 11;
    private static const AVG_THROW_IN_FIELD_ID = 12;
    private static const LONG_THROW_IN_FIELD_ID = 13;




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
            var courseDistStr = "" + courseDistance.toNumber() + " " + unitName;

            summaryStatsArr[4] = "Course Dist: " + courseDistStr;
            
            
            var courseDistField = session.createField("Course Distance", COURSE_D_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>courseDistStr.length() + 1,
                :units=>""
            });
            courseDistField.setData(courseDistStr);
                //Course Par
            var coursePar = Stats.getCoursePar(holeArray);
            summaryStatsArr[5] = "Course Par: " + coursePar;
            var parField = session.createField("Par", PAR_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :units=>""
            });
            parField.setData(coursePar);

                //Strokes
            var strokes = Stats.getTotalStrokes(holeArray);
            summaryStatsArr[6] = "Strokes: " + strokes;
            var strokesField = session.createField("Strokes", STROKES_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :units=>""
            });
            strokesField.setData(strokes);

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
            var birdiePerc = (Math.round(Stats.getBirdieRate(holeArray) * 100).toNumber());
            var birdiePercStr = "" + birdiePerc + "%"; //2 decimal places of precision would be cooler
            summaryStatsArr[8] = "Birdie Percentage: " + birdiePercStr;
            var birdiePercField = session.createField("Birdie Percentage", BIRD_PERC_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :units=>"%"
            });
            birdiePercField.setData(birdiePerc);
            
            //Adding driving stats

                //Fairway Hits
            var fairwayHits = Stats.getFairwayHits(holeArray);
            summaryStatsArr[9] = "Fairway Hits: " + (fairwayHits * 100).toNumber() + "%";
            var fairwayField = session.createField("Fairway Hits", FAIRWAY_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :units=>"%"
            });
            fairwayField.setData(fairwayHits * 100);

                //C1 %
            var c1InReg = Stats.getC1(holeArray);
            summaryStatsArr[10] = "C1 in Reg: " + (c1InReg * 100).toNumber() + "%";
            var c1InRegField = session.createField("C1 In Regulation", C1_REG_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :units=>"%"
            });
            c1InRegField.setData(c1InReg * 100);

                //C2 %
            var c2InReg = Stats.getC2(holeArray);
            summaryStatsArr[11] = "C2 in Reg: " + (c2InReg * 100).toNumber() + "%";
            var c2InRegField = session.createField("C2 In Regulation", C2_REG_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :units=>"%"
            });
            c2InRegField.setData(c2InReg * 100);

                //Scramble Percentage
            var scrambleArr = Stats.getScramble(holeArray);
            System.println(scrambleArr);
            var scramblePerc = "N/A";
            if (scrambleArr[1] != 0) {
                scramblePerc = "" + (Math.round(1.0 * scrambleArr[0]/scrambleArr[1] * 100).toNumber()) + "%";
            }
            summaryStatsArr[12] = "Scramble: " + scramblePerc;
            var scrambleField = session.createField("Scramble Percentage", SCRAMBLE_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>scramblePerc.length() + 1,
                :units=>"%"
            });
            scrambleField.setData(scramblePerc);
   
            var oBthrows = Stats.getObThrows(holeArray);
            summaryStatsArr[13] = "OB Throws: " + oBthrows;
            var oBThrowsField = session.createField("OB Throws", OB_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :units=>""
            });
            oBThrowsField.setData(oBthrows);
            //putting stats
            var c1Putting  = Stats.getC1Putting(holeArray);
            var c1PuttingPerc = "N/A";
            if (c1Putting[1] != 0) {
                c1PuttingPerc = "" + (Math.round(1.0 * c1Putting[0]/c1Putting[1] * 100).toNumber()) + "%";
            }
            summaryStatsArr[14] = "C1 Putting: " + c1PuttingPerc;
            var c1PuttingField = session.createField("C1 Putting", C1_PUTT_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>c1PuttingPerc.length() + 1,
                :units=>""
            });
            c1PuttingField.setData(c1PuttingPerc);

            var c2Putting  = Stats.getC2Putting(holeArray);
            var c2PuttingPerc = "N/A";
            if (c2Putting[1] != 0) {
                c2PuttingPerc = "" + (Math.round(1.0 * c2Putting[0]/c2Putting[1] * 100).toNumber()) + "%";
            }
            summaryStatsArr[15] = "C2 Putting: " + c2PuttingPerc;
            var c2PuttingField = session.createField("C2 Putting", C2_PUTT_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>c2PuttingPerc.length()+1,
                :units=>""
            });
            c2PuttingField.setData(c2PuttingPerc);

            var avgThrowIn = Stats.getAverageThrowIn(holeArray);
            var avgThrowInStr = "" + avgThrowIn + unitName;
            summaryStatsArr[16] = "Avg Throw-In: " + avgThrowInStr;            
            var avgThrowInField = session.createField("Average Throw In Distance", AVG_THROW_IN_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>avgThrowInStr.length() + 1,
                :units=>""
            });
            avgThrowInField.setData(avgThrowInStr);


            var longestThrowIn = Stats.getLongestThrowIn(holeArray);
            var longestThrowInStr = "" + longestThrowIn + unitName;
            summaryStatsArr[17] = "Longest Throw-In: " + longestThrowInStr;
            var longThrowInField = session.createField("Longest Throw In Distance", LONG_THROW_IN_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>longestThrowInStr.length() + 1,
                :units=>""
            });
            longThrowInField.setData(longestThrowInStr);


            //Laps stuff
            //Par

            // var parByLap = Stats.getParList(holeArray);
            // System.println(parByLap);
            // var parLapField = session.createField("Lap", PAR_LAP_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
            //     :mesgType=>FitContributor.MESG_TYPE_LAP,
            //     :units=>"",
            //     //:count=>parByLap.size() + 1,
            //     :count=>2,
            // });
            /*
            for (var i = 0; i < parByLap.size(); i++) {
                parLapField.setData(5);
            }
            */
            // parLapField.setData("" + 5);
            // parLapField.setData("" + 6);


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