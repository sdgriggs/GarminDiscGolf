using Toybox.WatchUi;

var reviewPageNumber;

class RoundReviewView extends WatchUi.View{
    function initialize(){
        WatchUi.View.initialize();
        reviewPageNumber = 0;
        
    }

    function onUpdate(dc){
        dc.clear(); 
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        if (reviewPageNumber == 0) {
            dc.drawText(dc.getWidth() / 2 , dc.getHeight() / 2 , Graphics.FONT_SYSTEM_SMALL, "REVIEW PAGE ZRO", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else if (reviewPageNumber == 1) {
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SYSTEM_SMALL, "REVIEW PAGE ONE", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else if (reviewPageNumber == 2) {
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SYSTEM_SMALL, "REVIEW PAGE TWO", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else {

            var hole = completedHoles.size();
            var dispMax = 9 * (reviewPageNumber - 2);
            if(dispMax > hole){
                dispMax = hole;
            }
            GraphicsUtil.drawScoreCard(dc, dispMax, completedHoles);
        }

    }
}