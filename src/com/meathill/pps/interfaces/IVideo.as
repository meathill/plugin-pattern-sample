/**
 * Created by 路佳 on 2015/2/20.
 */
package com.meathill.pps.interfaces {
public interface IVideo {
  function play(start:int = 0):void;
  function pause():void;
  function resume():void;
  function stop():void;
  function mute():void;
  function set volume(value:int):void;
  function get playhead():int;
  function get length():int;
}
}
