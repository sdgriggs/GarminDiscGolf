
using Toybox.Position;
using Toybox.Graphics;
class GraphicsUtil {
    public function showGPSStatus(dc, status){
        var length = 0;
        var penWidth = 10;
        var center = dc.getWidth() / 2;
        var rad = dc.getWidth() / 2 - penWidth;
        var start = 135;
        
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
}