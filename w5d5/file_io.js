function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  console.log(
    this.time.getHours() +
    ":" + this.time.getMinutes() +
    ":" + this.time.getSeconds()
  );
};

Clock.prototype.run = function () {
  this.time = new Date();
  // this.sec = initial.getSeconds();
  // this.min = initial.getMinutes();
  // this.hour = initial.getHours();
  this.printTime();

  setTimeout(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  this.time.setSeconds(this.time.getSeconds() + (Clock.TICK / 1000));
  this.printTime();
  setTimeout(this._tick.bind(this), Clock.TICK);
};

var clock = new Clock();
clock.run();
