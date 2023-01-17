using Toybox.WatchUi;
using Toybox.Math;
using Toybox.System;

/*
The end of Round stats view
*/
class RoundReviewView extends WatchUi.View{
    //The current page number
    private var reviewPageNumber;
    //The number of pages
    private var numPages;
    //The array of stats with display info
    private var statDisplayArr;

    function initialize(arr){
        WatchUi.View.initialize();
        reviewPageNumber = 0;
        statDisplayArr = arr;
        numPages = Math.ceil((1.0 * statDisplayArr.size() + 1) / 5).toNumber();      
    }
    //increment the current page number
    public function incrementPageNumber(){
        if (reviewPageNumber < numPages - 1){
            reviewPageNumber++;
            WatchUi.requestUpdate();
        }
    }
    //decrement the current page number
    public function decrementPageNumber(){
        if(reviewPageNumber > 0){
            reviewPageNumber--;
            WatchUi.requestUpdate();
        }
    }

    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear(); 
        GraphicsUtil.showPageBar(dc, numPages, reviewPageNumber);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        

        var displayString = "";

        if (reviewPageNumber == 0) {
            for (var i = 0; i < 4; i++) {
                displayString += statDisplayArr[i] + "\n";
            }
        } else if (reviewPageNumber == numPages - 1){
            for (var i = 5 * (reviewPageNumber - 1) + 4; i < statDisplayArr.size(); i++){
                displayString += statDisplayArr[i] + "\n";
            } 
        } else {
            for (var i = 5 * (reviewPageNumber - 1) + 4; i < 5 * (reviewPageNumber) + 4; i++){
                displayString += statDisplayArr[i] + "\n";
            } 
        }
        dc.drawText(dc.getWidth() / 2 , dc.getHeight() / 2 , Graphics.FONT_SYSTEM_XTINY, displayString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}