// This is you! Another MovingObject subclass.
(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function (pos, game) {
    Asteroids.MovingObject.call(this, pos, [0, 0], Ship.RADIUS, Ship.COLOR);
    this.game = game;
  }

  Ship.RADIUS = 5;
  Ship.COLOR = 'red';

  Asteroids.Utils.inherits(Ship, Asteroids.MovingObject);

  Ship.prototype.relocate = function() {
    this.pos = this.game.randomPosition();
    this.vel = [0, 0];
  };

  Ship.prototype.power = function(impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

})();
