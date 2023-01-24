using Toybox.WatchUi;
using Toybox.Lang;

//A class for picker factories to be used to provide a range of numbers to a picker
class RangePickerFactory extends WatchUi.PickerFactory {
    var first;
    var last;
    var step;
    //Takes the min and max value (inclusive) of the range as well as the step
    public function initialize (first, last, step) {
        WatchUi.PickerFactory.initialize();
        if (first == last || step == 0) {
            throw new Lang.Exception();
        }

        if (last > first && step < 0 || last < first && step > 0){
            throw new Lang.Exception();
        }
        self.first = first;
        self.last = last;
        self.step = step;
    }
    public function getDrawable(item, isSelected) {
        var value = getValue(item);

        return new WatchUi.Text({
            :text=>"" + value,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_SYSTEM_NUMBER_MILD,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }
    //Returns the number of items in the picker factory
    public function getSize(){
        return ((last - first) / step + 1).toNumber();
    }
    //Returns the value for an item
    public function getValue(item){
        return first + item * step;
    }
}