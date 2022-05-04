using Toybox.Test;
using Toybox.position;

var stPos = new Position.Location(
    {
        :latitude => 38.856147,
        :longitude => -94.800953,
        :format => :degrees
    });

//Tests constructor
(:test)
function testConstructor(logger){
    var fw = new FieldWork(stPos);
    Test.assertEqual(0, fw.getThrows().getSize());
    return true;
}