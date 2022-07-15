using Toybox.Math;
using Toybox.System;

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

    //Add in cooler stuff like fairway hits and stuff later
}