using Toybox.WatchUi;
using Toybox.System;

class ScoreCardView extends WatchUi.View{


    function initialize(){
        WatchUi.View.initialize();
    }


    function onUpdate(dc) { 
        
        
        var manager = RoundView.getInstance().getManager();
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        GraphicsUtil.showPageBar(dc, 2, 0);
        var width = dc.getWidth() * 0.9;
        var height = dc.getFontHeight(Graphics.FONT_SYSTEM_XTINY) * 3 + 20;
        var cellWidth = (Math.floor(width / 9)).toNumber();
        var rectOriginX = ((dc.getWidth() / 2) - (width / 2));
        var rectOriginY = ((dc.getHeight() / 2) - (height / 2));
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.setPenWidth(2);
        dc.drawRectangle(rectOriginX, rectOriginY , width, height);
        for (var i = 1; i < 9; i++){
            dc.drawLine(rectOriginX + (cellWidth * i), rectOriginY, rectOriginX + (cellWidth * i), rectOriginY + height);
        }
        var hole = manager.getCurrentHoleInfo()[1];
        var parList = Stats.getParList(manager.getHoles());
        var strokeList = Stats.getStrokeList(manager.getHoles());
        
        var start = 0;
        if (hole > 9) {
            start = hole - 9;
        }

        for( var i = 0; i < 9; i++) {
            dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (height / 6), Graphics.FONT_SYSTEM_XTINY, "" + (start + i +1), Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
            if (start + i < parList.size()) {
                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (height / 2), Graphics.FONT_SYSTEM_XTINY, "" + parList[start + i], Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (5 * height / 6), Graphics.FONT_SYSTEM_XTINY, "" + strokeList[start + i], Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );

            }
            else {
                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (height / 2), Graphics.FONT_SYSTEM_XTINY, "-", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (5 * height / 6), Graphics.FONT_SYSTEM_XTINY, "-", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
            }
        }

        dc.drawLine(rectOriginX, rectOriginY + (2 * height / 3).toNumber(), rectOriginX + width, rectOriginY + (2 * height / 3).toNumber());

        var score = Stats.getCombinedScore(RoundView.getInstance().getManager().getHoles());
        var scoreString = "" ;
        if(score > 0 ){
            scoreString = "+" + score;
        } else if (score < 0) {
            scoreString = "" + score;
        } else {
            scoreString = "E";
        }

        var bottomLine = ((dc.getHeight() / 2) - (height / 2) + dc.getFontHeight(Graphics.FONT_SYSTEM_XTINY) * 3 + 20);
        var bottomOfScreen = System.getDeviceSettings().screenHeight;
        var textYLoc = (bottomLine + bottomOfScreen) / 2;
        dc.drawText(dc.getWidth() / 2, textYLoc, Graphics.FONT_SYSTEM_SMALL, "Score: " + scoreString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
    }
}