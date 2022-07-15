using Toybox.WatchUi;

class ScoreCardView extends WatchUi.View{

    private var temporaryText;

    function initialize(){
        WatchUi.View.initialize();
        var score = Stats.getCombinedScore(RoundView.getInstance().getManager().getHoles());
        var scoreString = "" ;
        if(score > 0 ){
            scoreString = "+" + score;
        } else if (score < 0) {
            scoreString = "" + score;
        } else {
            scoreString = "E";
        }

        temporaryText = new WatchUi.Text({
            :text=>"Score: " + scoreString,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_SYSTEM_SMALL,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }


    function onUpdate(dc) { /*
        
        
        temporaryText.draw(dc);*/
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
        var scoreList = Stats.getScoreList(manager.getHoles());

        if (hole <= 9) {
            for( var i = 0; i < 9; i++) {
                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (height / 6), Graphics.FONT_SYSTEM_XTINY, "" + (i+1), Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
                if (i < parList.size()) {
                    var score = "E";
                    if(scoreList[i] > 0) {
                        score = "+" + scoreList[i];
                    } else if (scoreList[i] < 0) {
                        score = "" +  scoreList[i];
                    }
                    dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (height / 2), Graphics.FONT_SYSTEM_XTINY, "" + parList[i], Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
                    dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (5 * height / 6), Graphics.FONT_SYSTEM_XTINY, "" + score, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );

                }
                else {
                    dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (height / 2), Graphics.FONT_SYSTEM_XTINY, "-", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
                    dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (5 * height / 6), Graphics.FONT_SYSTEM_XTINY, "-", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
                }
            }

        } else {
            for( var i = 0; i < 9; i++) {


            }
        }
    }
}