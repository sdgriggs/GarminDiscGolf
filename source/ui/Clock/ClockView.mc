import Toybox.WatchUi;
import Toybox.System;
import Toybox.Graphics;

class ClockView extends WatchUi.View {
    var page;
    var totalPages;
    function initialize(page, totalPages) {
        WatchUi.View.initialize();
        self.page = page;
        self.totalPages = totalPages;
    }

    function onUpdate(dc) {
        //clear screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        //show gps status
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        //change colors back to normal and get time
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        var myTime = System.getClockTime(); // ClockTime object
        var hour = myTime.hour;
        //convert away from military time if necessary
        if (!System.getDeviceSettings().is24Hour && hour > 12) {
            hour -= 12;
        }
        //draw time
        dc.drawText(dc.getWidth() / 2, dc. getHeight() / 2 - dc.getFontHeight(Graphics.FONT_NUMBER_HOT) / 2, Graphics.FONT_NUMBER_HOT,
            "" + hour + ":" + myTime.min.format("%02d"), Graphics.TEXT_JUSTIFY_CENTER);

        //show page bar
        GraphicsUtil.showPageBar(dc, totalPages, page);

        //Request an update to get it to update in real time
        WatchUi.requestUpdate();
    }
}