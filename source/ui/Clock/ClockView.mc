import Toybox.WatchUi;
import Toybox.System;
import Toybox.Graphics;
import Toybox.Timer;

class ClockView extends WatchUi.View {
    var page;
    var totalPages;
    var timer;
    var timeString;
    function initialize(page, totalPages) {
        WatchUi.View.initialize();
        self.page = page;
        self.totalPages = totalPages;
        timer = new Timer.Timer();
    }

    function onShow() {
        updateTimeString();
        timer.start(method(:updateTimeString), 1000, true);
    }

    function onHide() {
        timer.stop();
    }

    function updateTimeString() {
        var myTime = System.getClockTime(); // ClockTime object
        var hour = myTime.hour;
        //convert away from military time if necessary
        if (!System.getDeviceSettings().is24Hour && hour > 12) {
            hour -= 12;
        }
        timeString = "" + hour + ":" + myTime.min.format("%02d");
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
        //clear screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        //show gps status
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        //change colors back to normal and get time
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        //draw time
        dc.drawText(dc.getWidth() / 2, dc. getHeight() / 2 - dc.getFontHeight(Graphics.FONT_NUMBER_HOT) / 2, Graphics.FONT_NUMBER_HOT,
            timeString, Graphics.TEXT_JUSTIFY_CENTER);

        //show page bar
        GraphicsUtil.showPageBar(dc, totalPages, page);

    }
}