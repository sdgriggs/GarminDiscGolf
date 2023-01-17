using Toybox.Math as Math;
using Stats;
/*
Represents a disc golf throw
*/
class Throw{
    //The location of the start of the Throw
    private var startPos;
    //The location of the end of the Throw
    private var endPos;
    //How far the throw went
    private var distance;
    //The outcome of the throw (FAIRWAY, OB, etc.)
    private var outcome;
    //Whether or not the throw is measured using the metric system
    private var isMetric;
    //The format used for the positions (positions are saved as a formatted string
    //and converted to a position instead of being saved as positions in order to
    //preserve memory)
    private var format = Position.GEO_MGRS;
    /*
    Creates a new Throw with the given start and end positions, outcome, and whether
    or not the throw should be measured usign the metric system.
    */
    public function initialize(startPos, endPos, outcome, isMetric){
        self.distance = Stats.measureDistanceBetweenLocations(startPos, endPos, isMetric);
        self.startPos = startPos.toGeoString(format);
        self.endPos = endPos.toGeoString(format);
        self.outcome = outcome;
        self.isMetric = isMetric;
    }
    
    //Returns the distance of the Throw
    public function getDistance(){
        return self.distance;
    }

    //Returns the start position of the Throw as a Position object
    public function getStartPos(){
        return Position.parse(startPos, format);
    }

    //Returns the end position of the Throw as a Position object
    public function getEndPos(){
        return Position.parse(endPos, format);
    }

    //Returns the outcome of the Throw
    public function getOutcome(){
        return self.outcome;
    }

}

/*
Represents the outcome of a throw
*/
enum Outcome{
    FAIRWAY,
    ROUGH,
    OB,
    IN_BASKET
}