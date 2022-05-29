import Toybox.Lang;

class LinkedList{

    protected var front;
    protected var back;
    private var size;

    public function initialize() {
        self.front = null;
        self.back = null;
        self.size = 0;
    }

    public function add(element) {
        //Special case of empty list
        if (size == 0){
            var temp = new ListNode(element, null, null);
            self.front = temp;
            self.back = temp;
            self.size++;
            return;
        }

        self.back.next = new ListNode(element, self.back, null);
        self.back = self.back.next;
        self.size++;
        
    }


    public function remove(index) {
        if (index < 0 || index >= self.size){
            throw new Lang.ValueOutOfBoundsException();
        }
        //special case of list of size 1
        if (self.size == 1){
            var temp = self.front.data;
            self.front = null;
            self.back = null;
            self.size--;
            return temp;
        }
        //special case of front
        if (index == 0){
            var temp = self.front.data;
            self.front = self.front.next;
            self.front.prev = null;
            self.size--;
            return temp;
        }
        //special case of end
        if (index == self.size - 1){
            var temp = self.back.data;
            self.back = self.back.prev;
            self.back.next = null;
            self.size--;
            return temp;            
        }
        //all other cases
        var current = front;
        //increment to the value before the one to remove
        for (var i = 1; i < index; i++){
            current = current.next;
        }
        var temp = current.next.data;
        //remove references to the one to be removed
        current.next = current.next.next;
        current.next.prev = current;
        self.size--;
        return temp;

    }

    public function get(index) {
        //throw exception if invalid index
        if (index < 0 || index >= self.size){
            throw new Lang.ValueOutOfBoundsException();
        }
        //special check for getting from back in constant time
        if (index == self.size -1){
            return back.data;
        }
        //get in all other cases
        var current = front;
        
        for (var i = 0; i < index; i++){
            current = current.next;
        }

        return current.data;
    }

    //returns the size of the linked list
    public function getSize() {
        return self.size;
    }
    //returns an array representation of the linked list
    public function toArray() {
        var array = new [self.size];
        var current = front;
        for (var i = 0; i < size; i++){
            array[i] = current.data;
            current = current.next;
        }
        return array;
    }


    //Represents one element/node in the linked list
    class ListNode{
        public var next;//the next node
        public var prev;//a weak reference to the previous node
        public var data;//the data contained by the node
        public function initialize(data, prev, next){
            if (data == null){
                throw new Lang.InvalidValueException();
            }
            self.data = data;
            if (prev != null){
                self.prev = prev.weak();
            } else {
                self.prev = null;
            }
            self.next = next;
        }
    }
}