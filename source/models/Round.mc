class Round{
    //An array of holes
    private var holes;
    //Whether or not distances are metric
    private var isMetric;

    public function initialize(numberOfHoles, isMetric){
        holes = new [numberOfHoles];
        self.isMetric = isMetric;
    }
}