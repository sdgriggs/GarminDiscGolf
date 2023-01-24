/*
Representing a simplified round of disc golf where only par and strokes are
kept track of.
*/
class SimpleRound{
    //An array of the pars
    private var pars;
    //An array of the strokes
    private var strokes;
    //the current hole
    private var currentHole;
    //Whether or not the round has been completed
    private var completed;
    /*
    Initializes a new SimpleRound with the given numberOfHoles and whether or not
    distances should be in metric
    */
    public function initialize(numberOfHoles){
        pars = new [numberOfHoles];
        strokes = new [numberOfHoles];
        currentHole = 0;
        completed = false;
    }

    //Returns an array containing information about the current hole to be used in the gui
    //In the format [if the tee has been marked, hole number (1 indexed), par, number of throws, 
    //current distance from tee]
    public function getCurrentHoleInfo(){
        return [true, currentHole + 1, pars[currentHole], 0, null];
    }

    //Sets the given par for the given hole (0 indexed)
    public function setPar(hole, par) {
        pars[hole] = par;
    }

    //Sets the given strokes for the given hole (0 indexed)
    public function setStrokes(hole, s) {
        strokes[hole] = s;
        if (hole == currentHole) {
            if (hole == strokes.size() - 1) {
                completed = true;
            } else {
                currentHole++;
            }
        }
    }

    //Returns whether or not the current hole needs to be initialized with a par
    public function needsInitializing(){
        return pars[currentHole] == null;
    }

    //Returns whether or not the round is completed
    public function isCompleted() {
        return completed;
    }

    //Returns the array of pars
    public function getPars(){
         return pars;
    }

    //Returns the array of strokes
    public function getStrokes(){
        return strokes;
    }
}