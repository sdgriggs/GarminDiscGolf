using Toybox.WatchUi;
using Stats;
using Toybox.FitContributor;
using Toybox.Activity;
using Toybox.System;
using Toybox.Application.Properties;
using Toybox.Application;
using Toybox.Math;


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
            var methodArrs = [[new Lang.method(Stats, :getCourseDistance), FitContributor.DATA_TYPE_STRING, false], 
                [new Lang.method(Stats, :getCombinedPar), FitContributor.DATA_TYPE_FLOAT, false], 
                [new Lang.method(Stats, :getTotalStrokes), FitContributor.DATA_TYPE_FLOAT, false], 
                [new Lang.method(Stats, :getTotalScoreAsString), FitContributor.DATA_TYPE_STRING, false], 
                [new Lang.method(Stats, :getBirdieRate), FitContributor.DATA_TYPE_STRING, true], 
                [new Lang.method(Stats, :getFairwayHits), FitContributor.DATA_TYPE_STRING, true], 
                [new Lang.method(Stats, :getC1), FitContributor.DATA_TYPE_STRING, true], 
                [new Lang.method(Stats, :getC2), FitContributor.DATA_TYPE_STRING, true], 
                [new Lang.method(Stats, :getScramble), FitContributor.DATA_TYPE_STRING, true], 
                [new Lang.method(Stats, :getObThrows), FitContributor.DATA_TYPE_FLOAT, false], 
                [new Lang.method(Stats, :getC1Putting), FitContributor.DATA_TYPE_STRING, true], 
                [new Lang.method(Stats, :getC2Putting), FitContributor.DATA_TYPE_STRING, true], 
                [new Lang.method(Stats, :getAverageThrowIn), FitContributor.DATA_TYPE_FLOAT, true], 
                [new Lang.method(Stats, :getLongestThrowIn), FitContributor.DATA_TYPE_FLOAT, true]];
                
            var summaryStatsArr = new [18];//The array with all the summary info
            //Get and add the generic activity data
            var activityInfo = Activity.getActivityInfo();
            var distWalkMet = activityInfo.elapsedDistance;
            var distWalkStr = "";
            if (unitName == "m") {
                distWalkStr += (distWalkMet / 1000).format("%.2f") + " km";
            } else {
                distWalkStr += (distWalkMet / 1609.34).format("%.2f") + " miles";
            }
            summaryStatsArr[0] = "Dist Walked: " + distWalkStr;

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

            summaryStatsArr[1] = "Time: " + timeStr;

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
            var c1InReg = Stats.getCX(holeArray, 1);
            summaryStatsArr[10] = "C1 in Reg: " + (c1InReg * 100).toNumber() + "%";
            var c1InRegField = session.createField("C1 In Regulation", C1_REG_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :units=>"%"
            });
            c1InRegField.setData(c1InReg * 100);

                //C2 %
            var c2InReg = Stats.getCX(holeArray, 2);
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

            var avgThrowIn = Stats.getAverageThrowIn(holeArray).toNumber();
            var avgThrowInStr = "" + avgThrowIn + unitName;
            summaryStatsArr[16] = "Avg Throw-In: " + avgThrowInStr;            
            var avgThrowInField = session.createField("Average Throw In Distance", AVG_THROW_IN_FIELD_ID, FitContributor.DATA_TYPE_STRING, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>avgThrowInStr.length() + 1,
                :units=>""
            });
            avgThrowInField.setData(avgThrowInStr);


            var longestThrowIn = Stats.getLongestThrowIn(holeArray).toNumber();
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