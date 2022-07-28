using Toybox.Math as Math;
using Stats;

class Throw{

    private var startPos;

    private var endPos;

    private var distance;

    private var outcome;

    private var isMetric;

    private var format = Position.GEO_MGRS;

    public function initialize(startPos, endPos, outcome, isMetric){
        self.distance = Stats.measureDistanceBetweenLocations(startPos, endPos, isMetric);
        self.startPos = startPos.toGeoString(format);
        self.endPos = endPos.toGeoString(format);
        self.outcome = outcome;
        self.isMetric = isMetric;
    }

    public function getDistance(){
        return self.distance;
    }

    public function getStartPos(){
        return Position.parse(startPos, format);
    }

    public function getEndPos(){
        return Position.parse(endPos, format);
    }

    public function getOutcome(){
        return self.outcome;
    }

}