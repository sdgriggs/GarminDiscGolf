using Toybox.Math as Math;

class Throw{

    private var startPos;

    private var endPos;


    public function initalize(startPos, endPos){
        self.startPos = startPos;
        self.endPos = endPos;
    }

    public function measureThrowDistance(){
        return self.measureThrowDistance(self.startPos, self.endPos);
    }

    //Measures the distance between two points
    // modified from https://www.geeksforgeeks.org/program-distance-two-points-earth/#:~:text=For%20this%20divide%20the%20values,is%20the%20radius%20of%20Earth.
    public static function measureDistanceBetweenLocations(startPos, endPos){
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
        var r = 6371;
 
        // calculate the result
        return(c * r) * 1000;
    }

    public function getStartPos(){
        return self.startPos;
    }

    public function getEndPos(){
        return self.endPos;
    }

}