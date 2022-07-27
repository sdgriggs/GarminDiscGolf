using Toybox.WatchUi;
using Toybox.Math;
using Toybox.System;



class RoundReviewView extends WatchUi.View{

    private var reviewPageNumber;
    private var numPages;
    private var statDisplayArr;

    function initialize(arr){
        WatchUi.View.initialize();
        reviewPageNumber = 0;
        statDisplayArr = arr;
        numPages = Math.ceil((statDisplayArr.size() + 1) / 5).toNumber();

        
    }

    public function incrementPageNumber(){
        if (reviewPageNumber < numPages - 1){
            reviewPageNumber++;
            WatchUi.requestUpdate();
        }
    }

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
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        

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
        

        /*
        if (reviewPageNumber == 0) {
            dc.drawText(dc.getWidth() / 2 , dc.getHeight() / 2 , Graphics.FONT_SYSTEM_SMALL, "REVIEW PAGE ZRO", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else if (reviewPageNumber == 1) {
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SYSTEM_SMALL, "REVIEW PAGE ONE", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else if (reviewPageNumber == 2) {
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SYSTEM_SMALL, "REVIEW PAGE TWO", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else {

            var hole = completedHoles.size();
            var dispMax = 9 * (reviewPageNumber - 2);
            GraphicsUtil.drawScoreCard(dc, dispMax, completedHoles);
        }
        */

    }
}