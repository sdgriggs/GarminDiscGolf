using Toybox.Position;
import Toybox.Lang;

/*
Represents a field work session
*/
class FieldWork {
    //List of throws in a fieldwork session
    private var throws;

    //current start location for the throws
    private var start;
    //If the units are in metric
    private var isMetric;

    /*
    Given a start location and if the units are metric,
    creates a new FieldWork session
    */
    public function initialize(st, isMetric) {
        throws = [];
        setStart(st);
        self.isMetric = isMetric;
    }

    //adds a new throw to the field work session
    public function addEndPoint(loc) {        
        throws.add(new Throw(start, loc, null, isMetric));
    }

    //gets the array of throws
    public function getThrows() {
        return throws;
    }

    //sets the start location
    public function setStart(st) {
        if (st instanceof Position.Location) {
            self.start = st;
        }
        else {
            throw new Lang.InvalidValueException();
        }
        
    }

    //gets the start locatoin
    public function getStart() {
        return self.start;
    }
}