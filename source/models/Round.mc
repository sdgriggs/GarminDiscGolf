class Round{
    //An array of holes
    private var holes;
    //Whether or not distances are metric
    private var isMetric;
    //the current hole
    private var currentHole;

    public function initialize(numberOfHoles, isMetric){
        holes = new [numberOfHoles];
        self.isMetric = isMetric;
        currentHole = 0;
    }
    //Calls undo for the current hole, or go back to the previous hole if there is no change
    //to undo on the current hole
    public function undo(){
        //if the current hole is uninitialized or unmarked
        if (holes[currentHole] == null || !holes[currentHole].isMarked()){
            //do nothing if it's the first hole
            if (currentHole == 0){
                return;
            }
            //otherwise go back a hole
            else{
                currentHole--;
                return;
            }
        }
        //otherwise call undo
        else {
            holes[currentHole].undo();
        }

    }
    //Returns an array containing information about the current hole to be used in the gui
    //In the format [if the tee has been marked, hole number (1 indexed), par, number of throws, 
    //current distance from tee]
    public function getCurrentHoleInfo(){
        var throws = holes[currentHole].getThrows();
        if (holes[currentHole] != null){
            return [holes[currentHole].isMarked(), currentHole + 1, holes[currentHole].getPar(), throws.getSize(), Stats.measureDistanceBetweenLocations(holes[currentHole].getTeePos, throws.get(throws.getSize() - 1).getEndPos(), isMetric)];
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
        if (holes[currentHole] != null){

            if (holes[currentHole].addThrow(endPos, outcome)) {//error handling occurs in Hole
                currentHole++;
            }
        }
    }
    //Initializes the current hole with a par if it is currently null
    public function initializeHole(par) {
        if (needsInitializing()){
            holes[currentHole] = new Hole(par, isMetric);
        }
    }
    //returns whether or not the current hole needs to be initialized with a par
    public function needsInitializing(){
        return holes[currentHole] == null;
    }
}