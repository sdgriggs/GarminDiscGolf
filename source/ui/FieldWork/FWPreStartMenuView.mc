using Toybox.WatchUi;
using Toybox.Position;
using Toybox.Graphics;
/*
Represents the FieldWork lap menu for when the tee has yet to be marked
*/
class FWPreStartMenuView extends WatchUi.View{
    
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
        dc.clear();
        GraphicsUtil.showGPSStatus(dc, gpsQuality);
        tempText.draw(dc);
    }
    
 
}    