import Toybox.Lang;

class ArrayList{

    var arr;
    var size;

    public function initialize() {
        arr = new [5];
        size = 0;
    }

    public function add(element) {
        //Special case of max capacity
        if (size == arr.size()){
            var temp = new [size * 2];
            for (var i = 0; i < size; i++) {
                temp[i] = arr[i];
            }
            arr = temp;
        }

        arr[size] = element;
        self.size++;
        
    }


    public function remove(index) {
        if (index < 0 || index >= self.size){
            throw new Lang.ValueOutOfBoundsException();
        }

        var temp = arr[index];
        
        for (var i = index + 1; i < size; i++) {
            arr[i - 1] = arr[i];
        }
        arr[size - 1] = null;
        size--;

        return temp;

    }

    public function get(index) {
        //throw exception if invalid index
        if (index < 0 || index >= self.size){
            throw new Lang.ValueOutOfBoundsException();
        }
        return arr[index];
    }

    //returns the size of the linked list
    public function getSize() {
        return self.size;
    }
    //returns an array representation of the linked list
    public function toArray() {
        var array = new [self.size];
        for (var i = 0; i < size; i++){
            array[i] = arr[i];
        }
        return array;
    }

}