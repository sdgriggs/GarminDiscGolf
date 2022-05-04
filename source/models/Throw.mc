using Toybox.Math as Math;
using Stats;

class Throw{

    private var startPos;

    private var endPos;

    private var distance;

    private var outcome;


    public function initialize(startPos, endPos, outcome){
        self.startPos = startPos;
        self.endPos = endPos;
        self.distance = Stats.measureDistanceBetweenLocations(startPos, endPos);
        self.outcome = outcome;
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

    public function getOutcome(){
        return self.outcome;
    }

}