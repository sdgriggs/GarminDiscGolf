module DistanceUtil {
    //Measures the distance between two points
    // modified from https://www.geeksforgeeks.org/program-distance-two-points-earth/#:~:text=For%20this%20divide%20the%20values,is%20the%20radius%20of%20Earth.
    public function measureDistanceBetweenLocations(startPos as Position.Location, endPos as Position.Location, isMetric as Boolean){
        var startPosRadians = startPos.toRadians();
        var endPosRadians = endPos.toRadians();

        var startLat = startPosRadians[0];
        var endLat = endPosRadians[0];
        var startLon = startPosRadians[1];
        var endLon = endPosRadians[1];

 
        // Haversine formula
        var dLon = endLon - startLon;
        var dLat = endLat - startLat;
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
}