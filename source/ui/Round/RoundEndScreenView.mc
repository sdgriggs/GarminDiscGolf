using Toybox.WatchUi;

class RoundEndScreenView extends WatchUi.Menu{
    public function initialize(){
        WatchUi.Menu.initialize();
        addItem("Round Stats", :round_stats);
        addItem("Holes", :holes);
        addItem("Scorecard", :scorecard);
        addItem("Done", :done);
        
    }
}