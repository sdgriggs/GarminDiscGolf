class SimpleRound{
    //An array of the pars
    private var pars;
    //An array of the strokes
    private var strokes;
    //the current hole
    private var currentHole;
    //Whether or not the round has been completed
    private var completed;


    

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

    public function setPar(hole, par) {
        pars[hole] = par;
    }

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
    //returns whether or not the current hole needs to be initialized with a par
    public function needsInitializing(){
        return pars[currentHole] == null;
    }

    public function isCompleted() {
        return completed;
    }

    public function getPars(){
         return pars;
    }

    public function getStrokes(){
        return strokes;
    }
}