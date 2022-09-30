class Hole{
    //List of throws in a hole
    private var throws;
    //The par of the hole
    private var par;
    //The tee pad position (might need it)
    private var teePos;
    //Whether or not distances are metric
    private var isMetric;
    //How many OB strokes there are
    private var extraStrokes;

    public function initialize(par, isMetric) {
        throws = [];
        setPar(par);
        teePos = null;
        extraStrokes = 0;
        self.isMetric = isMetric;
    }
    //sets the par for the hole assuming par is greater than 0
    public function setPar(par){
        if (par > 0){
            self.par = par;
        } else{
            //throw some kind of exception
        }
    }
    //returns the par for the hole
    public function getPar() {
        return par;
    }

    public function getScore() {
        return throws.size() + extraStrokes;
    }

    public function markTee(pos){
        if (throws.size() > 0){
            //Can't mark the tee once there are throws without going back
            return;
        }
        teePos = pos;
    }

    public function getTeePos() {
        return teePos;
    }
    //returns whether or not the tee has been marked
    public function isMarked(){
        return teePos != null;
    }

    //Adds a throw to the hole. Returns true if this throw was the end of the hole.
    public function addThrow(endPos, outcome){
        if (!isMarked()) {
            //Can't add a throw before the tee is marked
            //Maybe throw exception
            return false; 
        }
        else if (throws.size() == 0){
            //special case of first throw
            throws.add(new Throw(teePos, endPos, outcome, isMetric));
        }
        else{
            throws.add(new Throw(throws[throws.size() - 1].getEndPos(), endPos, outcome, isMetric));
        }
        if (outcome == IN_BASKET){
            return true;
        } else if (outcome == OB) {
            extraStrokes++;
        }

        return false;


    }

    //deletes the last added hole or resets the tee position to null
    //returns true if a change was made, false otherwise
    public function undo(){
        if (throws.size() > 0) {
            var lastThrow = throws[throws.size() - 1];
            throws.remove(lastThrow);
            if(lastThrow.getOutcome() == OB){
                extraStrokes--;
            }
            return true;
        } else if (isMarked()) {
            teePos = null;
            return true;
        }
        else {
            return false;
        }
    }

    //returns the linked list of throws
    public function getThrows(){
        return throws;
    }

    public function getIsMetric(){
        return isMetric;
    }


    


}