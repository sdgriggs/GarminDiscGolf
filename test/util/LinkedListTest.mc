using Toybox.Test;

module LinkedListTest{
//Tests LinkedList's constructor
(:test)
function testConstructor(logger){
    var ll = new LinkedList();
    Test.assertEqual(0, ll.getSize());
    return true;
}

//Tests LinkedList's add method
(:test)
function testAdd(logger){
    var ll = new LinkedList();
    Test.assertEqual(0, ll.getSize());//redundant, but whatever

    // try{ //test adding a null value (invalid)
    //     ll.add(null);
    //     Test.assertEqual(true, false);//fail if you get this far
    // } catch (exception) {
    //     Test.assertEqual(true,true);
    // }

    ll.add("UDisc");
    ll.add("But");
    ll.add("Garmin");

    Test.assertEqual(3, ll.getSize());//check that all three elements were added


    //Note to self, having to wrap your .get method in a try catch block is annoying and we
    //should probably change what exception is thrown
    try{
        Test.assertEqual("UDisc", ll.get(0));
        Test.assertEqual("But", ll.get(1));
        Test.assertEqual("Garmin", ll.get(2));
    } catch (exception){
        logger.debug("Error Will Robinson");
        return false;
    }

    return true;
}

//Tests LinkedList's remove method
(:test)
function testRemove(logger){
    var ll = new LinkedList();
    ll.add("Is");
    ll.add("this");
    ll.add("the");
    ll.add("real");
    ll.add("life?");
    ll.add("...");

    Test.assertEqual(6, ll.getSize());
    try{
        //remove front
        Test.assertEqual("Is", ll.remove(0));
        Test.assertEqual(5, ll.getSize());
        //remove back
        Test.assertEqual("...", ll.remove(4));
        Test.assertEqual(4, ll.getSize());
        //remove the rest
        Test.assertEqual("real", ll.remove(2));
        Test.assertEqual("the", ll.remove(1));
        Test.assertEqual("life?", ll.remove(1));
        Test.assertEqual("this", ll.remove(0));
        Test.assertEqual(0, ll.getSize());
    } catch (exception){
        logger.debug("Error Will Robinson");
        return false;
    }


    return true;
}

//Tests LinkedList's toArray() method
(:test)
function testToArray(logger){
    var ll = new LinkedList();


    Test.assertEqual(0, ll.toArray().size());

    ll.add("jeff");
    ll.add("geoff");
    ll.add("jeef");

    var arr = ll.toArray();

    Test.assertEqual(3, arr.size());
    Test.assertEqual("jeff", arr[0]);
    Test.assertEqual("geoff", arr[1]);
    Test.assertEqual("jeef", arr[2]);

    return true;
}
}