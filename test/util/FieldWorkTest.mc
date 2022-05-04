using Toybox.Test;
using Toybox.Position;

module FieldWorkTest{

    var stPos = new Position.Location(
        {
            :latitude => 38.856147,
            :longitude => -94.800953,
            :format => :degrees
        });

    //Tests constructor
    (:test)
    function testConstructor(logger){
        var fw = new FieldWork(stPos); //This should work but doesn't
        //var fw = new FieldWork(); //This works but shouldn't
        Test.assertEqual(0, fw.getThrows().getSize());
        //Test.assertEqual(stPos, fw.getStart());
        return true;
    }

}