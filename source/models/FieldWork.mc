using Toybox.Position;
import Toybox.Lang;


class FieldWork {
    //List of throws in a fieldwork session
    private var throws = new LinkedList();

    //current start location for the throws
    private var start = null;

    private var isMetric = false;


    public function initialize(st, isMetric) {
        setStart(st);
        if (isMetric){
            setMetric();
        }
        else {
            setImperial();
        }
    }

    //adds a throw location to the list of throws (This doesn't work)
    public function addEndPoint(loc) {        
        throws.add(new Throw(start, loc, null, isMetric));
    }

    //gets the linked list of throws
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

    public function setMetric(){
        isMetric = true;
    }

    public function setImperial(){
        isMetric = false;

        
    }
}