/*
Represents a full round of disc golf, including individual throws and holes.
*/
class Round{
    //An array of holes
    private var holes;
    //Whether or not distances are metric
    private var isMetric;
    //the current hole
    private var currentHole;
    //Whether or not the round has been completed
    private var completed;

    /*
    Initializes a new Round with the given numberOfHoles and whether or not
    distances should be in metric
    */
    public function initialize(numberOfHoles, isMetric){
        holes = new [numberOfHoles];
        self.isMetric = isMetric;
        currentHole = 0;
        completed = false;
    }
    /*
    Calls undo for the current hole, or goes back to the previous hole if 
    there is no change to undo on the current hole
    */
    public function undo(){
        //if the current hole is uninitialized
        if (holes[currentHole] == null){
            //do nothing if it's the first hole
            if (currentHole == 0){
                return;
            }
            //otherwise go back a hole
            else{
                currentHole--;
                holes[currentHole].undo();
                return;
            }
        } //otherwise if the hole is unmarked
        else if (!holes[currentHole].isMarked()) {
            holes[currentHole] = null;
        }
        //even more otherwise call undo
        else {
            if (completed) {
                completed = false;
            }
            holes[currentHole].undo();
        }

    }
    //Returns an array containing information about the current hole to be used in the gui
    //In the format [if the tee has been marked, hole number (1 indexed), par, number of throws, 
    //current distance from tee]
    public function getCurrentHoleInfo(){
        
        if (holes[currentHole] != null){
            var throws = holes[currentHole].getThrows();
            if (throws.size() > 0){
                return [holes[currentHole].isMarked(), currentHole + 1, holes[currentHole].getPar(), holes[currentHole].getScore(), Stats.measureDistanceBetweenLocations(holes[currentHole].getTeePos(), throws[throws.size() - 1].getEndPos(), isMetric)];
            } else {
                return [holes[currentHole].isMarked(), currentHole + 1, holes[currentHole].getPar(), holes[currentHole].getScore(), 0];
            }
        }
        else {
            return [false, currentHole + 1, null, 0, null];
        }
    }
    //Marks the tee for the current hole assuming the tee has not been marked yet
    public function markTee(pos){
        if (holes[currentHole] != null){
            holes[currentHole].markTee(pos);//error handling occurs in Hole
        }
    }
    //Adds a throw to the current hole assuming the tee has been marked. Creates
    //the next hole when outcome is IN_BASKET
    public function addThrow(endPos, outcome){
        if (holes[currentHole] != null && !completed){

            if (holes[currentHole].addThrow(endPos, outcome)) {//error handling occurs in Hole
                currentHole++;
            }
            //marks completed true if the round has been completed
            if (currentHole == holes.size()) {
                currentHole--;
                completed = true;
            }
        }
    }

    //Sets the given par for the given hole (0 indexed)
    public function setPar(hole, par) {
        if (holes[hole] == null) {
            holes[currentHole] = new Hole(par, isMetric);
        }
        else {
            holes[hole].setPar(par);
        }
    }

    //Returns whether or not the current hole needs to be initialized with a par
    public function needsInitializing(){
        return holes[currentHole] == null;
    }

    //Returns whether or not the round is completed
    public function isCompleted() {
        return completed;
    }

    //Returns the array of holes
    public function getHoles(){
        return holes;
    }

    public function getLastThrow(){
        return getHoles()[currentHole].getLastThrow();

    }
}