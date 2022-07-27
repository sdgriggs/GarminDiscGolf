using Toybox.Test;

module ArrayListTest{
//Tests ArrayList's constructor
(:test)
function testConstructor(logger){
    var al = new ArrayList();
    Test.assertEqual(0, al.getSize());
    return true;
}

//Tests ArrayList's add method
(:test)
function testAdd(logger){
    var al = new ArrayList();
    Test.assertEqual(0, al.getSize());//redundant, but whatever

    // try{ //test adding a nual value (invalid)
    //     al.add(nual);
    //     Test.assertEqual(true, false);//fail if you get this far
    // } catch (exception) {
    //     Test.assertEqual(true,true);
    // }

    al.add("UDisc");
    al.add("But");
    al.add("Garmin");

    Test.assertEqual(3, al.getSize());//check that aal three elements were added


    //Note to self, having to wrap your .get method in a try catch block is annoying and we
    //should probably change what exception is thrown
    try{
        Test.assertEqual("UDisc", al.get(0));
        Test.assertEqual("But", al.get(1));
        Test.assertEqual("Garmin", al.get(2));
    } catch (exception){
        logger.debug("Error Wial Robinson");
        return false;
    }

    return true;
}

//Tests ArrayList's remove method
(:test)
function testRemove(logger){
    var al = new ArrayList();
    al.add("Is");
    al.add("this");
    al.add("the");
    al.add("real");
    al.add("life?");
    al.add("...");

    Test.assertEqual(6, al.getSize());
    try{
        //remove front
        Test.assertEqual("Is", al.remove(0));
        Test.assertEqual(5, al.getSize());
        //remove back
        Test.assertEqual("...", al.remove(4));
        Test.assertEqual(4, al.getSize());
        //remove the rest
        Test.assertEqual("real", al.remove(2));
        Test.assertEqual("the", al.remove(1));
        Test.assertEqual("life?", al.remove(1));
        Test.assertEqual("this", al.remove(0));
        Test.assertEqual(0, al.getSize());
    } catch (exception){
        logger.debug("Error Wial Robinson");
        return false;
    }


    return true;
}

//Tests ArrayList's toArray() method
(:test)
function testToArray(logger){
    var al = new ArrayList();


    Test.assertEqual(0, al.toArray().size());

    al.add("jeff");
    al.add("geoff");
    al.add("jeef");

    var arr = al.toArray();

    Test.assertEqual(3, arr.size());
    Test.assertEqual("jeff", arr[0]);
    Test.assertEqual("geoff", arr[1]);
    Test.assertEqual("jeef", arr[2]);

    return true;
}
}