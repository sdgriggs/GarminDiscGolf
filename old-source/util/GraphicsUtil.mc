
using Toybox.Position;
using Toybox.Graphics;
using Toybox.Lang;

class GraphicsUtil {
    public function showGPSStatus(dc, status){
        var length = 0;
        var penWidth = 10;
        var center = dc.getWidth() / 2;
        var rad = dc.getWidth() / 2 - penWidth;
        var start = 135;
        var end = 45;
        dc.setPenWidth(penWidth);
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        dc.drawArc(center, center, rad, Graphics.ARC_CLOCKWISE, start, end);
        if(status == Position.QUALITY_NOT_AVAILABLE) {
            length = 2;
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        } else if (status == Position.QUALITY_LAST_KNOWN){
            length = 10;
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        } else if (status == Position.QUALITY_POOR) {
            length = 40;
            dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);
        } else if (status == Position.QUALITY_USABLE) {
            length = 70;
            dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
        } else if (status == Position.QUALITY_GOOD) {
            length = 90;
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        } else {
            length = 2;
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        }
        
        dc.drawArc(center, center, rad, Graphics.ARC_CLOCKWISE, start, start - length );
        
    }

    public function showPageBar (dc, numPages, pageIdx) {
        if (pageIdx < 0 || pageIdx >= numPages) {
            throw new Lang.Exception();
        }
        var penWidth = 7;
        var centerx = dc.getWidth() / 2;
        var centery = dc.getHeight() / 2;
        var rad = dc.getWidth() / 2 - penWidth;
        var start = 150;
        var end = 210;
        dc.setPenWidth(penWidth);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_LT_GRAY);
        dc.drawArc(centerx, centery, rad, Graphics.ARC_COUNTER_CLOCKWISE, start, end);
        
        
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        var len = (end - start) / numPages;
        var start2 = start + pageIdx * len;
        var end2 = (start2 + len).toNumber();

        start2 = start2.toNumber();
        if(end2 > end) {
            end2 = end;
        }

        dc.drawArc(centerx, centery, rad, Graphics.ARC_COUNTER_CLOCKWISE, start2, end2);
        
    }

    public function drawScoreCard(dc, hole, parList, strokeList, roundInProgress){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        var width = dc.getWidth() * 0.9;
        var height = dc.getFontHeight(Graphics.FONT_SYSTEM_XTINY) * 3 + 20;
        var cellWidth = (Math.floor(width / 9)).toNumber();
        var rectOriginX = ((dc.getWidth() / 2) - (width / 2));
        var rectOriginY = ((dc.getHeight() / 2) - (height / 2));
        dc.setPenWidth(2);

        //draw text
        var start = 0;
        if (hole > 9) {
            start = hole - 9;
        }
        var upperBound = parList.size();
        if (upperBound > 9) {
            upperBound = 9;
        }
        for( var i = 0; i < upperBound; i++) {
            if (start + i < parList.size()) {
                var par = parList[start + i];
                var strokes = strokeList[start + i];
                par = (par == null || par == 0) ? "-" : "" + par;
                strokes = (strokes == null || strokes == 0) ? "-" : "" + strokes;

                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (height / 6), Graphics.FONT_SYSTEM_XTINY, "" + (start + i +1), Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );

                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (height / 2), Graphics.FONT_SYSTEM_XTINY, par, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (5 * height / 6), Graphics.FONT_SYSTEM_XTINY, strokes, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );

            }
            else {
                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (height / 2), Graphics.FONT_SYSTEM_XTINY, "", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
                dc.drawText(rectOriginX + (cellWidth * i) + (cellWidth / 2), rectOriginY + (5 * height / 6), Graphics.FONT_SYSTEM_XTINY, "", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
            }
        }

        //draw scorecard box
        dc.drawRectangle(rectOriginX, rectOriginY , width, height);
        for (var i = 1; i < 9; i++){
            dc.drawLine(rectOriginX + (cellWidth * i), rectOriginY, rectOriginX + (cellWidth * i), rectOriginY + height);
        }
        dc.drawLine(rectOriginX, rectOriginY + (2 * height / 3).toNumber(), rectOriginX + width, rectOriginY + (2 * height / 3).toNumber());
        var score;
        if (roundInProgress) {
            score = Stats.getCombinedScore({:pars => parList.slice(0, hole - 1), :strokes => strokeList.slice(0, hole - 1)});
        }
        else {
            score = Stats.getCombinedScore({:pars => parList, :strokes => strokeList});
        }
        var scoreString = Stats.convertScoreToString(score);

        var bottomLine = ((dc.getHeight() / 2) - (height / 2) + dc.getFontHeight(Graphics.FONT_SYSTEM_XTINY) * 3 + 20);
        var bottomOfScreen = System.getDeviceSettings().screenHeight;
        var textYLoc = (bottomLine + bottomOfScreen) / 2;
        dc.drawText(dc.getWidth() / 2, textYLoc, Graphics.FONT_SYSTEM_SMALL, "Score: " + scoreString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}