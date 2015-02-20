/**
 * Created by 路佳 on 2015/2/19.
 */
package com.meathill.pps.model {
import com.meathill.pps.interfaces.IParams;

import flash.events.EventDispatcher;

[Event(name='complete', type='flash.events.Event')]
public class MovieInfo extends EventDispatcher implements IParams {
  private var _src:String = '';
  public function MovieInfo(parameters:Object) {
    _src = parameters.src || _src;
  }

  public function get src():String {
    return _src;
  }

  public function getPluginData(pluginID:String):Object {
    return null;
  }
}
}
