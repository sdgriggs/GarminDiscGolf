using Toybox.Math as Math;
using Stats;

class Throw{

    private var startPos;

    private var endPos;

    private var distance;


    public function initalize(startPos, endPos){
        self.startPos = startPos;
        self.endPos = endPos;
        self.distance = Stats.measureDistanceBetweenLocations(startPos, endPos);
    }

    public function getDistance(){
        return self.distance;
    }

    public function getStartPos(){
        return self.startPos;
    }

    public function getEndPos(){
        return self.endPos;
    }

}