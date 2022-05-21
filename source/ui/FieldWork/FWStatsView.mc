using Toybox.Graphics;
using Toybox.WatchUi;
using Stats;
using Toybox.Application.Properties;
using Toybox.Math;
using Toybox.System;

class FWStatsView extends WatchUi.View{
    private var title;
    private var stats;

    function initialize(throwArr){
        WatchUi.View.initialize();

        title = new WatchUi.Text({
            :text=>"Summary",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_SYSTEM_TINY,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY =>WatchUi.LAYOUT_VALIGN_TOP,
        });

        var unitName = "ft";
        if (Properties.getValue("isMetric")){
            unitName = "m";
        }

        var statsString = "";
        statsString += "Throws: " + throwArr.size() + "\n";
        statsString += "Total Distance: " + Math.round(Stats.totalDist(throwArr)).toNumber() + unitName + "\n";
        statsString += "Avg. Distance: " + Math.round(Stats.getAvgDist(throwArr)).toNumber() + unitName + "\n";
        statsString += "Max Distance: " + Math.round(Stats.getMaxDist(throwArr)).toNumber() + unitName + "\n";
        statsString += "Min Distance: " + Math.round(Stats.getMinDist(throwArr)).toNumber() + unitName;

        stats = new WatchUi.TextArea({
            :text=>statsString,
            :color=>Graphics.COLOR_WHITE,
            :font=>[Graphics.FONT_SYSTEM_XTINY],
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM,
            :width=>System.getDeviceSettings().screenWidth,
            :height=>System.getDeviceSettings().screenHeight - Graphics.getFontHeight(Graphics.FONT_SYSTEM_TINY)
            //:width=>180,
            //:height=>180
        });

    }

    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        //title.draw(dc);
        //dc.drawLine(x1, y1, x2, y2);
        stats.draw(dc);
        title.draw(dc);
        
    }
}