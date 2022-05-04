using Toybox.Math as Math;
using Stats;

class Throw{

    private var startPos;

    private var endPos;

    private var distance;

    private var outcome;

    private var isMetric;

    public function initialize(startPos, endPos, outcome, isMetric){
        self.startPos = startPos;
        self.endPos = endPos;
        self.distance = Stats.measureDistanceBetweenLocations(startPos, endPos, isMetric);
        self.outcome = outcome;
        self.isMetric = isMetric;
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