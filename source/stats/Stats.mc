using Toybox.Math;
using Toybox.System;
using Toybox.Lang;
using Toybox.FitContributor;

module Stats{
      public function totalDist(throws){
        var sum = 0;
        for (var i = 0; i < throws.size(); i++){
            sum += throws[i].getDistance();
        }
        return sum;
    }
    //Takes an array of throws and returns the average distance
    public function getAvgDist(throws){

        return totalDist(throws) / throws.size();
    }

    public function getMinDist(throws){
        if (throws.size() == 0){//edge case of no throws
            return 0;
        }
        var min = throws[0].getDistance();
        for (var i = 1; i < throws.size(); i++){
            var dist = throws[i].getDistance();
            if(dist < min){
                min = dist;
            }
        }
        return min;
    }

    public function getMaxDist(throws){
        if (throws.size() == 0){//edge case of no throws
            return 0;
        }
        var max = throws[0].getDistance();
        for (var i = 1; i < throws.size(); i++){
            var dist = throws[i].getDistance();
            if(dist > max){
                max = dist;
            }
        }
        return max;
    }

    //Measures the distance between two points
    // modified from https://www.geeksforgeeks.org/program-distance-two-points-earth/#:~:text=For%20this%20divide%20the%20values,is%20the%20radius%20of%20Earth.
    public function measureDistanceBetweenLocations(startPos, endPos, isMetric){
        var lon1 = startPos.toRadians()[1];
        var lon2 = endPos.toRadians()[1];
        var lat1 = startPos.toRadians()[0];
        var lat2 = endPos.toRadians()[0];
 
        // Haversine formula
        var dlon = lon2 - lon1;
        var dlat = lat2 - lat1;
        var v = Math.pow(Math.sin(dlat / 2), 2)
                 + Math.cos(lat1) * Math.cos(lat2)
                 * Math.pow(Math.sin(dlon / 2),2);
             
        var c = 2 * Math.asin(Math.sqrt(v));
 
        // Radius of earth in kilometers. Use 3956
        // for miles
        var r_metric = 6371;
        var r_imperial = 3956;

        if( isMetric == true) {
            return (c * r_metric) * 1000;
        }
        // calculate the result
        return (c * r_imperial) * 5280;
    }
    //Experimental function that will write the stat to the FIT file and return the stat
    public function writeRoundStat(completedStatsList, method, args, session, id, type, units, isPercentage) {
        var data = method.invoke(args);
        if (isPercentage && data != null && data instanceof Lang.Float) {
            data *= 100;
        }
        if (!(data instanceof Lang.String) && data != null) {
            data = data.toNumber();
        }
        if (type == FitContributor.DATA_TYPE_STRING){
            var strData = "N/A";
            if (data != null) {
                if (data instanceof Lang.String) {
                    strData = data;
                }
                else {
                    strData = "" + data.toNumber();
                    if (isPercentage) {
                        strData += "%";
                    }
                }
            }
            strData += units;
            var field = session.createField("" + id, id, type, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :count=>strData.length() + 1,
                :units=>""
            });
            field.setData(strData);
            completedStatsList.add(field);
            return strData;
        } else {
            var field = session.createField("" + id, id, type, {
                :mesgType=>FitContributor.MESG_TYPE_SESSION,
                :units=>units
            });
            field.setData(data);
            completedStatsList.add(field);
        }
        return data;
    }
    //returns the list of pars from a hole array for all holes
    public function getFullParList(holes) {
        var arr = new [holes.size()];
        for (var i = 0; i < arr.size(); i++) {
            if (holes[i] == null) {
                break;
            }
            arr[i] = holes[i].getPar();
        }
        return arr;
    }
    //returns the list of pars for the completed holes of a hole array
    public function getParList(holes) {
        return getFullParList(holes).slice(0, getHolesCompleted(holes));
    }
    //pass in a holeArray or a parList
    public function getCombinedPar(args) {
        var parList;
        var strokesList;
        var size;
        if (args[0] instanceof Hole){
            parList = getParList(args);
            strokesList = parList;
        } else {
            parList = args.get(:pars);
            strokesList = args.get(:strokes);
        }
        var sum = 0;

        for (var i = 0; i < parList.size() && parList[i] != null && strokesList[i] != null; i++){
            sum += parList[i];
        }

        return sum;
    }
    //pass in either a hole array or a stroke array
    public function getHolesCompleted(args) {
        var size = args.size();
        if (size == 0) {
            return 0;
        }

        var simple = false;
        if (!(args[0] instanceof Hole)) {
            simple = true;
        }
        for (var i = size - 1; i >= 0; i--) {
            if (args[i] == null || (!simple && (args[i].getThrows().size() == 0 || args[i].getThrows()[args[i].getThrows().size() - 1].getOutcome() != IN_BASKET))){
                size--;
            }
            else {
                break;
            }
        }

        return size;
    }

    public function getFullStrokeList(holes){
        var strokeList = new [holes.size()];
        for (var i = 0; i < strokeList.size(); i++) {
            if (holes[i] == null) {
                break;
            }
            strokeList[i] = holes[i].getScore();
        }

        return strokeList;
    }

    public function getStrokeList(holes){
        return getFullStrokeList(holes).slice(0, getHolesCompleted(holes));
    }

    public function getTotalStrokes(args){
        var parList;
        var strokesList;
        if (args[0] instanceof Hole){
            strokesList = getStrokeList(args);
            parList = strokesList;
        } else {
            strokesList = args.get(:strokes);
            parList = args.get(:pars);
        }
        var sum = 0;

        for (var i = 0; i < strokesList.size() && strokesList[i] != null && parList[i] != null; i++){
            sum += strokesList[i];
        }

        return sum;
    }

    public function getScoreList(holes){
        var parList = getParList(holes);
        var scoreList = new [getHolesCompleted(holes)];
        for (var i = 0; i < getHolesCompleted(holes); i++) {
            scoreList[i] = holes[i].getScore() - parList[i];
        }

        return scoreList;
    }
    //pass in a whole array or a dictionary with :pars and :strokes
    public function getCombinedScore(args){

        if (!(args[0] instanceof Hole)){
            var strokesList = args.get(:strokes);
            var parList = args.get(:pars);
            var sum = 0;
            for (var i = 0; i < strokesList.size() && parList[i] != null && strokesList[i] != null; i++) {
                sum += strokesList[i] - parList[i];
            }

            return sum;

        }
        var scoreList = getScoreList(args);
        var sum = 0;

        for (var i = 0; i < scoreList.size(); i++){
            sum += scoreList[i];
        }

        return sum;
    }

    public function convertScoreToString(score) {
        if (score < 0) {
            return "" + score;
        } else if (score > 0) {
            return "+" + score;
        } 

        return "E";
    
    }

    public function getTotalScoreAsString(args) {
        return convertScoreToString(getCombinedScore(args));
    }

    //Measures the total distance thrown over an array of holes
    public function getTotalDistanceThrown(holeArray){
        var dist = 0;
        for (var i = 0; i < getHolesCompleted(holeArray); i++){
            var thr = holeArray[i].getThrows();
            for(var j = 0; j < thr.size(); j++){
                dist += thr[j].getDistance();
            }
        }

        return dist;
    }
    //Measures the distance of a course given as an array of holes
    //Distance is calculated as the sum of the distances between each hole's teepad and basket
    public function getCourseDistance(holeArray){
        var dist = 0;
        for (var i = 0; i < getHolesCompleted(holeArray); i++){
            var thr = holeArray[i].getThrows();
            dist += measureDistanceBetweenLocations(thr[0].getStartPos(), thr[thr.size() - 1].getEndPos(), holeArray[i].getIsMetric());
        }

        return dist;
    }

    // public function getCoursePar(holeArray){
    //     var par = 0;
    //     for( var i = 0 ; i < getHolesCompleted(holeArray); i++){
    //         par += holeArray[i].getPar();
    //     }

    //     return par;
    // }

    //Returns the number of holes with a birdie or better divided by the number of holes played
    public function getBirdieRate(args){
        var birdieCount = 0;
        var parList;
        var strokeList;
        if (args[0] instanceof Hole) {
            parList = getParList(args);
            strokeList = getStrokeList(args);
        } else {
            parList = args.get(:pars);
            strokeList = args.get(:strokes);
        }
        var numHolesCompleted = 0;
        for (var i = 0; i < parList.size() && parList[i] != null && strokeList[i] != null; i++){
            if(parList[i] > strokeList[i]){
                birdieCount++;
            }
            numHolesCompleted++;
        }
        return 1.0 * birdieCount / numHolesCompleted;
    }

    public function inC1(pos, hole) {
        var thr = hole.getThrows();
        return measureDistanceBetweenLocations(pos, thr[thr.size()-1].getEndPos(), true) < 10;
    }

    public function inC2(pos, hole) {
        var thr = hole.getThrows();
        return measureDistanceBetweenLocations(pos, thr[thr.size()-1].getEndPos(), true) < 20;
    }

    //Returns the ratio of fairways hit to total applicable shots. Attempts to follow the udisc rules for
    //what counts as a fairway hit.
    public function getFairwayHits(holeArray){
        var fw = 0;//fairway hits
        var tot = 0;//total applicable shots
        for (var i = 0; i < getHolesCompleted(holeArray); i ++){
            var thr = holeArray[i].getThrows();

            if(holeArray[i].getPar() > 3){//for longer holes
                var possibleHitCount = holeArray[i].getPar() - 3;
                if (thr.size() < possibleHitCount) { //Then you're insane
                    possibleHitCount = thr.size();
                } 
                tot += possibleHitCount;//add the number of shots
                for (var j = 0; j < possibleHitCount; j++) {//iterate through all the shots
                    var outcome = thr[j].getOutcome();
                    if (outcome == IN_BASKET || outcome == FAIRWAY || inC2(thr[j].getEndPos(), holeArray[i])) {
                        fw++;//increment fairway hits if applicable
                    }
                }
            }
            else{//for shorter holes only care about the first throw and if it's in c2
                if (thr[0].getOutcome() == IN_BASKET || inC2(thr[0].getEndPos(), holeArray[i])){
                    fw++;
                }
                tot++;
            }
        }
        return 1.0 * fw/tot;
    }

    public function getCXPutting(holeArray, circleNum){
        var make = 0;
        var total = 0;
        for (var i = 0; i < getHolesCompleted(holeArray); i ++){
            var thr = holeArray[i].getThrows();
            var holeLoc = thr[thr.size() - 1].getEndPos();
            for(var j = 0; j < thr.size(); j++){
                var dist = measureDistanceBetweenLocations(thr[j].getStartPos(), holeLoc, true);
                if( dist >= 10 * (circleNum - 1) && dist < 10 * circleNum){
                    if( j == thr.size() - 1){
                        make++;
                    }
                    total++;
                }
            }
        }
        if (total == 0) {
            return null;
        }
        return 1.0 * make / total;
    }

    public function getC1Putting(holeArray){
        return getCXPutting(holeArray, 1);
    }

    public function getC2Putting(holeArray){
        return getCXPutting(holeArray, 2);
    }

    public function getScramble(holeArray){
        var make = 0;
        var total = 0;
        for (var i = 0; i < getHolesCompleted(holeArray); i ++){
            var thr = holeArray[i].getThrows();
            for(var j = 0; j < thr.size(); j++){
                    var outcome = thr[j].getOutcome();
                    if(outcome == ROUGH || outcome == OB) {
                        total++;
                        if(holeArray[i].getPar() >= holeArray[i].getScore()){
                            make++;
                        }
                        break;
                    }
                }
        }
        if (total == 0) {
            return null;
        }
        return 1.0 * make / total;
    }


    public function getCX(holeArray, circleNum){
        var cx = 0;
        var elligibleHoles = 0;
        for( var i = 0; i < getHolesCompleted(holeArray); i++){
            var throws = holeArray[i].getThrows();
            var endPos = throws[throws.size() - 1].getEndPos();
            var stPos = null;
            if (holeArray[i].getPar() <= 2 ){
                continue;
            }
            elligibleHoles++;
            if(holeArray[i].getScore() <= holeArray[i].getPar() - 2)
            {
                cx++;
            }
            else{
                var strokes = 0;
                for(var v = 0; v < throws.size(); v++){
                    strokes++;
                    if(throws[v].getOutcome() == OB) {
                        strokes++;
                    }
                    if(strokes > holeArray[i].getPar() - 2){
                        break;
                    } else if (strokes == holeArray[i].getPar() - 2){
                        stPos = throws[v].getEndPos();
                        break;
                    }
                }
                if(stPos != null && measureDistanceBetweenLocations(stPos, endPos, true) <= circleNum * 10){
                    cx++;
                }
            }
        }
            if(elligibleHoles > 0){
                return 1.0 * cx / elligibleHoles;
            } else {
                return null;
            }    
        }

        public function getC1(holeArray) {
            return getCX(holeArray, 1);
        }

        public function getC2(holeArray) {
            return getCX(holeArray, 2);
        }

        public function getObThrows(holeArray){
            var ob = 0;
            for( var i = 0; i < getHolesCompleted(holeArray); i++){
                ob += holeArray[i].getScore() - holeArray[i].getThrows().size();                
            }
            return ob;
        }

        public function getLongestThrowIn(holeArray){
            var long = 0;
            for( var i = 0; i < getHolesCompleted(holeArray); i++){
                var x = holeArray[i].getThrows()[holeArray[i].getThrows().size() - 1].getDistance();
                if(long < x){
                    long = x;
                }
            }
            return long;
        }

        public function getAverageThrowIn(holeArray){
            var sum = 0;
            for( var i = 0; i < getHolesCompleted(holeArray); i++){
                sum += holeArray[i].getThrows()[holeArray[i].getThrows().size() - 1].getDistance();
                
            }
            return 1.0 * sum / getHolesCompleted(holeArray);
        }
    
}