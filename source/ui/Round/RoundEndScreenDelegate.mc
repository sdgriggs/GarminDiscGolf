using Toybox.WatchUi;

class RoundEndScreenDelegate extends WatchUi.MenuInputDelegate{
    private var summaryStatsArr;

    public function initialize(arr){
        WatchUi.MenuInputDelegate.initialize();
        summaryStatsArr = arr;
    }


    public function onMenuItem(item){
        if(item == :round_stats){
            var view = new RoundReviewView(summaryStatsArr);
            WatchUi.pushView(view, new RoundReviewDelegate(view), WatchUi.SLIDE_RIGHT);
        } else if (item == :holes){
            //TODO
        } else if (item == :scorecard){
            //TODO
        } else if (item == :done) {
            //Currently do nothing
        }
    }
}