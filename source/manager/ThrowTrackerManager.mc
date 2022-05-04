class ThrowTrackerManager{
    private var startPos;
    private var throws;

    public function initialize(startPos){
        self.throws = new LinkedList();
        self.startPos = startPos;
    }

    public function addThrow(endPos){
        throws.add(new Throw(self.startPos, endPos)); //should run in constant time
    }

    public function getNumberOfThrows(){
        return throws.getSize(); //should run in constant time
    }

    public function getDistanceOfLastThrow(){
        return throws.get(throws.getSize() - 1).getDistance(); // currently runs in linear time, but can be made constant
    }

    public function getMaxDistance(){
        //Here's where the linked list implementation has flaws. If we extend the generic linked list class
        //and make a specific one for Throws we can implement these methods in the list class itself and
        //get much better performance
        var distance = 0;
        for (var i = 0; i < throws.size(); i++){
            var throwDistance = throws.get(i).getDistance();
            if (throwDistance > distance){
                distance = throwDistance;
            }
        }

        return distance;
    }

    public function getMinDistance(){
        //Just like getMaxDistance, there are optimizations to be made here
        if (throws.getSize() == 0){ // base case
            return 0;
        }

        var distance = throws.get(0);
        for (var i = 1; i < throws.size(); i++){
            var throwDistance = throws.get(i).getDistance();
            if (throwDistance < distance){
                distance = throwDistance;
            }
        }

        return distance;

    }

    public function getAverageDistance(){
        var sum = 0;

        for (var i = 0; i < throws.getSize(); i++){
            sum += throws.get(i).getDistance();
        }

        return sum / throws.getSize();
    }
}