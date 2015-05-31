// Spacerock. It inherits from MovingObject.
(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }


  var Asteroid = Asteroids.Asteroid = function (pos, game) {
    var vel = Asteroids.Utils.randVector(); // Pass in length later

    Asteroids.MovingObject.call(this, pos, vel, Asteroid.RADIUS, Asteroid.COLOR);
    this.game = game;
  };

  Asteroids.Utils.inherits(Asteroid, Asteroids.MovingObject);

  Asteroid.COLOR = 'black';
  Asteroid.RADIUS = 20;

  Asteroid.prototype.collideWith = function(otherObject) {
    // this.game.remove(otherObject);
    // this.game.remove(this);

    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    }
  }



})();
