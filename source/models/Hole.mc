/*
Represents a hole in a round of disc golf
*/
class Hole{
    //List of throws in a hole
    private var throws;
    //The par of the hole
    private var par;
    //The tee pad position of the hole
    private var teePos;
    //Whether or not distances are metric
    private var isMetric;
    //How many OB strokes there are
    private var extraStrokes;

    /*
    Initializes a new hole with the given par and
    whether or not distances should be metric.
    */
    public function initialize(par, isMetric) {
        throws = [];
        setPar(par);
        teePos = null;
        extraStrokes = 0;
        self.isMetric = isMetric;
    }

    //Sets the par for the hole assuming par is greater than 0
    public function setPar(par){
        if (par > 0){
            self.par = par;
        } else{
            //throw some kind of exception
        }
    }

    //Returns the par for the hole
    public function getPar() {
        return par;
    }

    //Returns the score for the hole
    public function getScore() {
        return throws.size() + extraStrokes;
    }

    //Sets the tee position for the hole
    public function markTee(pos){
        if (throws.size() > 0){
            //Can't mark the tee once there are throws without going back
            return;
        }
        teePos = pos;
    }

    //Returns the tee position for the hole
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
            return false; 
        }
        else if (throws.size() == 0){
            //If its first throw use the teePos for the start
            throws.add(new Throw(teePos, endPos, outcome, isMetric));
        }
        else{
            //Otherwise use the end location of the last throw for the start
            throws.add(new Throw(throws[throws.size() - 1].getEndPos(), endPos, outcome, isMetric));
        }

        //Increment extra strokes if the throw was OB
        if (outcome == OB) {
            extraStrokes++;
        }

        //Return whether or not the throw was the end of the hole
        return outcome == IN_BASKET;
    }
    /*
    Undos the last action done to the Hole (deletes the last added throw or 
    resets the tee position to null).
    Returns true if a change was made, false otherwise.
    */
    public function undo(){
        if (throws.size() > 0) {
            //delete the last throw if applicable
            var lastThrow = throws[throws.size() - 1];
            throws.remove(lastThrow);
            if(lastThrow.getOutcome() == OB){
                extraStrokes--;
            }
            return true;
        } else if (isMarked()) {
            //otherwise reset the tee position to null if applicable
            teePos = null;
            return true;
        }
        else {
            //otherwise do nothing and return false
            return false;
        }
    }

    //Returns the array of throws
    public function getThrows(){
        return throws;
    }

    //Returns whether or not the hole uses the metric system for distances.
    public function getIsMetric(){
        return isMetric;
    }

    public function getLastThrow(){
        System.println(getThrows());
        if(throws.size() < 1){
            return null;
        }        
        return throws[throws.size()-1];
    }
    


}