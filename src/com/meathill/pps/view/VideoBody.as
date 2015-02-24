/**
 * Created by 路佳 on 2015/2/19.
 */
package com.meathill.pps.view {
import com.meathill.pps.interfaces.IVideo;

import flash.display.Sprite;

import flash.events.AsyncErrorEvent;
import flash.events.MouseEvent;
import flash.events.NetStatusEvent;
import flash.events.SecurityErrorEvent;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;

public class VideoBody extends Sprite implements IVideo {
  private var nc:NetConnection;
  private var ns:NetStream;
  private var _meta:Object;
  private var max_width:uint;
  private var max_height:uint;
  private var video:Video;
  private var _is_playing:Boolean;
  public function VideoBody(width:uint, height:uint) {
    max_width = width;
    max_height = height;

    video = new Video(width, height);
    addChild(video);

    nc = new NetConnection();
    nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, nc_securityErrorHandler);
    nc.connect(null);

    addEventListener(MouseEvent.CLICK, clickHandler);
  }

  public function set volume(value:int):void {

  }

  public function get playhead():int {
    return 0;
  }

  public function get length():int {
    return 0;
  }

  public function get meta():Object {
    return _meta;
  }

  public function get playing():Boolean {
    return _is_playing;
  }

  public function loadMovie(src:String):void {
    _is_playing = true;
    ns.play(src);
  }

  public function play(start:int = 0):void {
    _is_playing = true;
    ns.play();
  }

  public function pause():void {
    _is_playing = false;
    ns.pause();
  }

  public function resume():void {
    _is_playing = true;
    ns.resume();
  }

  public function stop():void {

  }

  public function mute():void {

  }

  public function onMetaData(info:Object):void {
    _meta = info;

    // resize
    if (info.width && info.height) {
      info.width = parseInt(info.width);
      info.height = parseInt(info.height);
      resize(info.width, info.height);
    }
  }


  private function createStream():void {
    ns = new NetStream(nc);
    ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, ns_asyncErrorHandler);
    ns.client = this;
    video.attachNetStream(ns);
  }
  private function resize(w:uint, h:uint):void {
    if (w === 0 || h === 0) {
      return;
    }
    if (w / h > max_width / max_height) {
      video.width = max_width;
      video.height = h / w * max_width;
    } else {
      video.height = max_height;
      video.width = w / h * max_height;
    }
    video.x = max_width - video.width >> 1;
    video.y = max_height - video.height >> 1;
  }

  private function ns_asyncErrorHandler(event:AsyncErrorEvent):void {
    trace('async error: ' + event);
  }

  private function nc_securityErrorHandler(event:SecurityErrorEvent):void {
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

  private function clickHandler(event:MouseEvent):void {

  }
}
}
