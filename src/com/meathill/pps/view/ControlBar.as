/**
 * Created by 路佳 on 2015/2/19.
 */
package com.meathill.pps.view {
import flash.display.Sprite;
import flash.events.MouseEvent;

public class ControlBar extends Sprite {
  private var _video:VideoBody;
  public function ControlBar(video:VideoBody) {
    _video = video;

    layout();

    addEventListener(MouseEvent.CLICK, clickHandler);
  }

  private function layout():void {
    graphics.beginFill(0x336699);
    graphics.drawRect(0, 0, 360, 40);
    graphics.endFill();
    useHandCursor = true;
  }

  private function clickHandler(event:MouseEvent):void {
    if (_video.playing) {
      _video.pause();
    } else {
      _video.resume();
    }

  }
}
}
