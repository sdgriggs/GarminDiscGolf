class Hole{
    //List of throws in a hole
    private var throws;
    //The par of the hole
    private var par;
    //The tee pad position (might need it)
    private var teePos;
    //Whether or not distances are metric
    private var isMetric;

    public function initialize(par, isMetric) {
        throws = new LinkedList();
        setPar(par);
        teePos = null;
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

    public function markTee(pos){
        if (throws.getSize() > 0){
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
        else if (throws.getSize() == 0){
            //special case of first throw
            throws.add(new Throw(teePos, endPos, outcome, isMetric));
        }
        else{
            throws.add(new Throw(teePos, endPos, outcome, isMetric));
        }
        if (outcome == IN_BASKET){
            return true;
        }
        else {
            return false;
        }

    }

    //deletes the last added hole or resets the tee position to null
    //returns true if a change was made, false otherwise
    public function undo(){
        if (throws.getSize() > 0) {
            throws.remove(throws.getSize() - 1);
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


    


}