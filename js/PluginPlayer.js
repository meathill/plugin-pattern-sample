class PluginPlayer {
  constructor(el, options) {
    options = options || {};
    this.getElement(el);
    this.createVideo(options);
    this.createControlBar();
    this.delegateEvent();
  }

  createControlBar() {
    this.el.append(`<nav class="navbar navbar-light bg-faded">
      <div class="form-inline play-pause">
        <button class="btn btn-primary play-button"><i class="fa fa-play"></i></button>
        <button class="btn btn-primary pause-button"><i class="fa fa-pause"></i></button>
      </div>
      <div class="progress">
        <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="0"></div>
      </div>
      <span class="navbar-brand">
        PluginPlayer
      </span>
    </nav>`);
  }

  createVideo(options) {
    options = _.defaults(options, {
      width: 800,
      height: 400
    });
    let video = this.video = document.createElement('video');
    _.each(options, (value, key) => {
      video[key] = value;
    });
    this.el.append(video);
  }

  delegateEvent() {
    this.el
      .on('click', '.play-button', event => {
        this.video.play();
        this.el.addClass('playing')
          .removeClass('await pause');
      })
      .on('click', '.pause-button', event => {
        this.video.pause();
        this.el.addClass('pause')
          .removeClass('await playing');
      });
    this.video.addEventListener('loadedmetadata', this.onMetaData.bind(this), true);
    this.video.addEventListener('playing', this.onPlaying.bind(this), true);
    this.video.addEventListener('pause', this.onPause.bind(this), true);
  }

  getElement(selector) {
    let el = this.el = $(selector);
    el.addClass('plugin-player await');
    this.$ = el.find;
    return el;
  }

  onMetaData(event) {
    this.length = this.video.duration;
  }

  onPause(event) {
    clearInterval(this.interval);
  }

  onPlaying(event) {
    this.interval = setInterval( () => {
      let played = this.video.played;
      this.el.find('.progress-bar').width(played.end(0) / this.length * 100 + '%');
    }, 1000);
  }
}