
// using Toybox.Lang;

// //An extension of LinkedList for Throws with added methods for throw statistics pertaining specifically
// //to the throw tracker
// class ThrowTrackerThrowList extends LinkedList{
//     public function initialize(){
//         LinkedList.initialize();
//     }

//     public function add(element){
//         if (!(element instanceof Throw)){
//             throw new Lang.InvalidValueException();
//         }

//         LinkedList.add(element);
//     }
    
//     public function addThrow(startPos, endPos){
//         LinkedList.add(new Throw(startPos, endPos));
//     }

//     public function getDistanceOfLastThrow(){
//         if (LinkedList.size() == 0){
//             return 0;
//         }
//         return LinkedList.back.measureThrowDistance();
//     }

//     public function getMaxDistance(){
//         var current = LinkedList.front;
//         var max = 0;

//         while (current != null){
//             var throwDist = current.data.measureThrowDistance();
//             if (throwDist > max){
//                 max = throwDist;
//             }
//             current = current.next;
//         }

//         return max;
//     }

//     public function getMinDistance(){
//         var current = LinkedList.front;

//         if (current == null){
//             return 0;
//         }

//         var min = current.data.measureThrowDistance();
//         current = current.next;

//         while (current != null){
//             var throwDist = current.data.measureThrowDistance();
//             if (throwDist < min){
//                 min = throwDist;
//             }
//             current = current.next;
//         }

//         return min;
//     }

//     public function getAverageDistance(){
//         var current = LinkedList.front;
//         var sum = 0;

//         while (current != null){
//             sum += current.data.measureThrowDistance();
//             current = current.next;
//         }

//         return sum / LinkedList.getSize();
//     }
// }