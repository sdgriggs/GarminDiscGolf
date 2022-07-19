using Toybox.WatchUi;

class RoundEndScreenDelegate extends WatchUi.BehaviorDelegate{

    public function initialize(){
        WatchUi.BehaviorDelegate.initialize();
    }


    public function onMenuItem(item){
        if(item == :round_stats){
            reviewPageNumber = 0;
        } else if (item == :holes){
            
        }
    }
}
