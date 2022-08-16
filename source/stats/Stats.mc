using Toybox.Math;
using Toybox.System;
using Toybox.Lang;

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

    public function getParList(holes) {
        var arr = new [getHolesCompleted(holes)];
        for (var i = 0; i < getHolesCompleted(holes); i++) {
            arr[i] = holes[i].getPar();
        }
        return arr;
    }

    public function getCombinedPar(holes) {
        var parList = getParList(holes);
        var sum = 0;

        for (var i = 0; i < parList.size(); i++){
            sum += parList[i];
        }

        return sum;
    }

    public function getHolesCompleted(holes) {
        var size = holes.size();
        for (var i = size - 1; i >= 0; i--) {
            if (holes[i] == null || holes[i].getThrows().getSize() == 0 || holes[i].getThrows().get(holes[i].getThrows().getSize() - 1).getOutcome() != IN_BASKET){
                size--;
            }
            else {
                break;
            }
        }

        return size;
    }

    public function getStrokeList(holes){
        var strokeList = new [getHolesCompleted(holes)];
        for (var i = 0; i < getHolesCompleted(holes); i++) {
            strokeList[i] = holes[i].getScore();
        }

        return strokeList;
    }

    public function getTotalStrokes(holeArray){
        var strokes = 0;
        for( var i = 0; i < getHolesCompleted(holeArray); i++){
            strokes += holeArray[i].getScore();
        }
        return strokes;
    }

    public function getScoreList(holes){
        var parList = getParList(holes);
        var scoreList = new [getHolesCompleted(holes)];
        for (var i = 0; i < getHolesCompleted(holes); i++) {
            scoreList[i] = holes[i].getScore() - parList[i];
        }

        return scoreList;
    }

    public function getCombinedScore(holes){
        var scoreList = getScoreList(holes);
        System.println(scoreList);
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

    //Measures the total distance thrown over an array of holes
    public function getTotalDistanceThrown(holeArray){
        var dist = 0;
        for (var i = 0; i < getHolesCompleted(holeArray); i++){
            var thr = holeArray[i].getThrows().toArray();
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
            var thr = holeArray[i].getThrows().toArray();
            dist += measureDistanceBetweenLocations(thr[0].getStartPos(), thr[thr.size() - 1].getEndPos(), holeArray[i].getIsMetric());
        }

        return dist;
    }

    public function getCoursePar(holeArray){
        var par = 0;
        for( var i = 0 ; i < getHolesCompleted(holeArray); i++){
            par += holeArray[i].getPar();
        }

        return par;
    }

    //Returns the number of holes with a birdie or better divided by the number of holes played
    public function getBirdieRate(holeArray){
        var birdieCount = 0;
        var numHolesCompleted = getHolesCompleted(holeArray);
        for (var i = 0; i < numHolesCompleted; i++){
            if(holeArray[i].getPar() > holeArray[i].getScore()){
                birdieCount++;
            }
        }
        return 1.0 * birdieCount / numHolesCompleted;
    }

    public function inC1(pos, hole) {
        var thr = hole.getThrows();
        return measureDistanceBetweenLocations(pos, thr.get(thr.getSize()-1).getEndPos(), true) < 10;
    }

    public function inC2(pos, hole) {
        var thr = hole.getThrows();
        return measureDistanceBetweenLocations(pos, thr.get(thr.getSize()-1).getEndPos(), true) < 20;
    }

    //Returns the ratio of fairways hit to total applicable shots. Attempts to follow the udisc rules for
    //what counts as a fairway hit.
    public function getFairwayHits(holeArray){
        var fw = 0;//fairway hits
        var tot = 0;//total applicable shots
        for (var i = 0; i < getHolesCompleted(holeArray); i ++){
            var thr = holeArray[i].getThrows().toArray();

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

    public function getC1Putting(holeArray){
        var make = 0;
        var total = 0;
        for (var i = 0; i < getHolesCompleted(holeArray); i ++){
            var thr = holeArray[i].getThrows().toArray();
            var holeLoc = thr[thr.size() - 1].getEndPos();
            for(var j = 0; j < thr.size(); j++){
                if(inC1(thr[j].getStartPos(), holeArray[i])){
                    if( j == thr.size() - 1){
                        make++;
                    }
                    total++;
                }
            }

        }
        return [make, total] ;
    }

    public function getC2Putting(holeArray){
        var make = 0;
        var total = 0;
        for (var i = 0; i < getHolesCompleted(holeArray); i ++){
            var thr = holeArray[i].getThrows().toArray();
            var holeLoc = thr[thr.size() - 1].getEndPos();
            for(var j = 0; j < thr.size(); j++){
                var dist = measureDistanceBetweenLocations(thr[j].getStartPos(), holeLoc, true);
                if( dist > 10 && dist < 20){
                    if( j == thr.size() - 1){
                        make++;
                    }
                    total++;
                }
            }

        }
        return [make, total] ;
    }

    public function getScramble(holeArray){
        var make = 0;
        var total = 0;
        for (var i = 0; i < getHolesCompleted(holeArray); i ++){
            var thr = holeArray[i].getThrows().toArray();
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
        return [make, total] ;
    }


    public function getC1(holeArray){
        var c1 = 0;
        var elligibleHoles = 0;
        for( var i = 0; i < getHolesCompleted(holeArray); i++){
            var throws = holeArray[i].getThrows();
            var endPos = throws.get(throws.getSize() - 1).getEndPos();
            var stPos = null;
            if (holeArray[i].getPar() <= 2 ){
                continue;
            }
            elligibleHoles++;
            if(holeArray[i].getScore() <= holeArray[i].getPar() - 2)
            {
                c1++;
            }
            else{
                var strokes = 0;
                for(var v = 0; v < throws.getSize(); v++){
                    strokes++;
                    if(throws.get(v).getOutcome() == OB) {
                        strokes++;
                    }
                    if(strokes > holeArray[i].getPar() - 2){
                        break;
                    } else if (strokes == holeArray[i].getPar() - 2){
                        stPos = throws.get(v).getStartPos();
                        break;
                    }
                }
                if(stPos != null && measureDistanceBetweenLocations(stPos, endPos, true) <= 10){
                    c1++;
                }
            }
        }
            if(elligibleHoles > 0){
                return 1.0 * c1 / elligibleHoles;
            } else {
                return 0;
            }
            
            
                
        }


    public function getC2(holeArray){
        var c1 = 0;
        var elligibleHoles = 0;
        for( var i = 0; i < getHolesCompleted(holeArray); i++){
            var throws = holeArray[i].getThrows();
            var endPos = throws.get(throws.getSize() - 1).getEndPos();
            var stPos = null;
            if (holeArray[i].getPar() <= 2 ){
                continue;
            }
            elligibleHoles++;
            if(holeArray[i].getScore() <= holeArray[i].getPar() - 2)
            {
                c1++;
            }
            else{
                var strokes = 0;
                for(var v = 0; v < throws.getSize(); v++){
                    strokes++;
                    if(throws.get(v).getOutcome() == OB) {
                        strokes++;
                    }
                    if(strokes > holeArray[i].getPar() - 2){
                        break;
                    } else if (strokes == holeArray[i].getPar() - 2){
                        stPos = throws.get(v).getStartPos();
                        break;
                    }
                }
                if(stPos != null && measureDistanceBetweenLocations(stPos, endPos, true) <= 20){
                    c1++;
                }
            }
        }

            System.println(elligibleHoles);
            System.println(c1);
            if(elligibleHoles > 0){
                return 1.0 * c1 / elligibleHoles;
            } else {
                return 0;
            }
            
            
                
        }

        public function getObThrows(holeArray){
            var ob = 0;
            for( var i = 0; i < getHolesCompleted(holeArray); i++){
                ob += holeArray[i].getScore() - holeArray[i].getThrows().getSize();                
            }
            return ob;
        }

        public function getLongestThrowIn(holeArray){
            var long = 0;
            for( var i = 0; i < getHolesCompleted(holeArray); i++){
                var x = holeArray[i].getThrows().get(holeArray[i].getThrows().getSize() - 1).getDistance();
                if(long < x){
                    long = x;
                }
            }
            return long;
        }

        public function getAverageThrowIn(holeArray){
            var sum = 0;
            for( var i = 0; i < getHolesCompleted(holeArray); i++){
                sum += holeArray[i].getThrows().get(holeArray[i].getThrows().getSize() - 1).getDistance();
                
            }
            return 1.0 * sum / getHolesCompleted(holeArray);
        }
    
}