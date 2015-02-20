/**
 * Created by 路佳 on 2015/2/19.
 */
package com.meathill.pps.view {
import com.meathill.pps.interfaces.IVideo;

import flash.events.AsyncErrorEvent;
import flash.events.NetStatusEvent;
import flash.events.SecurityErrorEvent;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;

public class VideoBody extends Video implements IVideo {
  private var nc:NetConnection;
  private var ns:NetStream;
  public function VideoBody(width:int, height:int) {
    super(width, height);
    nc = new NetConnection();
    nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
    nc.connect(null);
  }

  public function set volume(value:int):void {

  }

  public function get playhead():int {
    return 0;
  }

  public function get length():int {
    return 0;
  }

  public function loadMovie(src:String):void {
    ns.play(src);
  }

  public function play(start:int = 0):void {
    ns.play();
  }

  public function pause():void {
    ns.pause();
  }

  public function resume():void {
    ns.resume();
  }

  public function stop():void {

  }

  public function mute():void {

  }

  private function createStream():void {
    ns = new NetStream(nc);
    ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
    this.attachNetStream(ns);
  }

  private function asyncErrorHandler(event:AsyncErrorEvent):void {
    trace('async error: ' + event);
  }

  private function securityErrorHandler(event:SecurityErrorEvent):void {
    trace('security error: ' + event);
  }

  private function netStatusHandler(event:NetStatusEvent):void {
    switch (event.info.code) {
      case 'NetConnection.Connect.Success':
        createStream();
        break;

      case 'NetStream.Play.StreamNotFound':
        trace('no video file');
        break;
    }
  }
}
}
