using Toybox.WatchUi;

class RoundEndScreenDelegate extends WatchUi.MenuInputDelegate{
    private var summaryStatsArr;
    private var parList;
    private var strokesList;

    public function initialize(arr, parList, strokesList){
        WatchUi.MenuInputDelegate.initialize();
        summaryStatsArr = arr;
        self.parList = parList;
        self.strokesList = strokesList;
    }


    public function onMenuItem(item){
        if(item == :round_stats){
            var view = new RoundReviewView(summaryStatsArr);
            WatchUi.pushView(view, new RoundReviewDelegate(view), WatchUi.SLIDE_RIGHT);
        } else if (item == :scorecard){
            var view = new ScoreCardView(parList, strokesList);
            WatchUi.pushView(view, new ScoreCardEndDelegate(view), WatchUi.SLIDE_RIGHT);
        } else if (item == :done) {
            //Currently do nothing
        }
    }
}
