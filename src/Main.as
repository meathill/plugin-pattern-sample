package {

import com.meathill.pps.model.MovieInfo;
import com.meathill.pps.view.VideoBody;
import com.meathill.pps.view.ControlBar;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

public class Main extends Sprite {
  private var info:MovieInfo;
  private var video:VideoBody;
  private var control:ControlBar;

  public function Main() {
    stage.scaleMode = StageScaleMode.NO_SCALE;
    stage.align = StageAlign.TOP_LEFT;

    info = new MovieInfo(loaderInfo.parameters)
    info.addEventListener(Event.COMPLETE, info_completeHandler);
    layout();
  }

  private function info_completeHandler(event:Event):void {
    video.loadMovie(info.src);
  }

  private function layout():void {
    video = new VideoBody(640, 360);
    addChild(video);

    control = new ControlBar();
    control.y = 360;
    addChild(control);
  }
}
}
