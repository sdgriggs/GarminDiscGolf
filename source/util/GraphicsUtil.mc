
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
        
        dc.setPenWidth(penWidth);
        
        dc.drawArc(center, center, rad, Graphics.ARC_CLOCKWISE, start, start - length );
        
        System.println("GPS STATUS DRAWN");
    }

    public function showPageBar (dc, numPages, pageIdx) {
        if (pageIdx < 0 || pageIdx >= numPages) {
            throw new Lang.Exception();
        }
        var penWidth = 3;
        var center = dc.getWidth() / 2;
        var rad = dc.getWidth() / 2 - penWidth;
        var start = 150;
        var end = 210;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_LT_GRAY);
        dc.drawArc(center, center, rad, Graphics.ARC_COUNTER_CLOCKWISE, start, end);
        
        
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        var len = (end - start) / numPages;
        var start2 = start + pageIdx * len;
        var end2 = (start2 + len).toNumber();

        start2 = start2.toNumber();
        if(end2 > end) {
            end2 = end;
        }

        dc.drawArc(center, center, rad, Graphics.ARC_COUNTER_CLOCKWISE, start2, end2);
        
    }
}