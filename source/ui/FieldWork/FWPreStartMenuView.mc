using Toybox.WatchUi;
using Toybox.Position;
using Toybox.Graphics;

class FWPreStartMenuView extends WatchUi.View{
    
    /*
    private var quality;
    private static const signalNames = {
        Position.QUALITY_NOT_AVAILABLE => "None",
        Position.QUALITY_LAST_KNOWN => "None",
        Position.QUALITY_POOR => "Poor",
        Position.QUALITY_USABLE => "Moderate",
        Position.QUALITY_GOOD => "Good"
    };

    function initialize(){
        View.initialize();
    /*
        self.quality = Position.getInfo().accuracy;
        setTitle("GPS:" + signalNames.get(gpsQuality));
        addItem("Mark Start", :start);
        System.print("init");
    }
    function onLayout(dc){
        //GraphicsUtil.showGPSStatus(dc, gpsQuality);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
        dc.fillRectangle(100, 100, 100, 100);
        System.print("Layout");
        //return true;
    }

    function onShow() {
        System.print("Show");
    }

    function onUpdate(dc) {
        System.print("UPDATE");
        var tempText = new WatchUi.Text({
            :text=>"Not Yet Implemented",
            :color=>Graphics.COLOR_RED,
            :font=>Graphics.FONT_MEDIUM,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
        tempText.draw(dc);
        //GraphicsUtil.showGPSStatus(dc, gpsQuality);
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
        dc.fillRectangle(100, 100, 100, 100);
        View.onUpdate(dc);
    }

    function onHide() {
        System.print("Hide");
    }*/

    private var tempText;

    function initialize(){
        WatchUi.View.initialize();
    }

    function onShow(){
        if(isTS){
            tempText = new WatchUi.Text({
                :text=>"Tap Screen To\nConfirm Tee",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            });
        } else {
            tempText = new WatchUi.Text({
                :text=>"Confirm Tee\nwith Select Button",
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_SMALL,
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            }); 
        }
    }

    function onUpdate(dc){
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        //var status = gpsQuality;
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        tempText.draw(dc);

        System.println("UPDATED NEW");
    }
    
 
}    