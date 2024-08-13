using Toybox.Position;
import Toybox.Lang;

/*
Represents a field work session
*/
class FieldWork {
    var throws as Lang.Array<Throw>;
    var startPos as Position.Location;
    var isMetric as Lang.Boolean;

    function initialize(start as Position.Location, isMetric as Lang.Bool) as Void {
        self.startPos = start;        
        self.isMetric = isMetric;
        self.throws = [];
    }

    /**
    *Returns the distance of the last throw or 0 if there are none
    */
    function getLastThrowDist() as Lang.Float {
        return throws.size() > 0 ? throws[throws.size() - 1].getDistance() : 0;
    }
}