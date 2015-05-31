// Holds collections of the asteroids, bullets, and your ship.
// #step method calls #move on all the objects, and #checkCollisions checks for colliding objects.
// #draw(ctx) draws the game.
// Keeps track of dimensions of the space; wraps objects around when they drift off the screen.

(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.addAsteroids();
    this.ship = new Asteroids.Ship([375, 375], this); // Random Position
  };

  Game.DIM_X = 750;
  Game.DIM_Y = 750;
  Game.NUM_ASTEROIDS = 2;

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      var asteroidPos = this.randomPosition();
      var asteroid = new Asteroids.Asteroid(asteroidPos, this);
      this.asteroids.push(asteroid);
    }
  };

  Game.prototype.allObjects = function () {
    var objects = [];
    this.asteroids.forEach(function (arg) {
      objects.push(arg);
    });
    objects.push(this.ship);
    return objects;
  };

  Game.prototype.randomPosition = function () {
    var x = Math.floor(Math.random() * Game.DIM_X);
    var y = Math.floor(Math.random() * Game.DIM_Y);
    return [x, y];
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, Game.DIM_X + Asteroids.Asteroid.RADIUS, Game.DIM_Y + Asteroids.Asteroid.RADIUS);
    this.allObjects().forEach(function (arg) {
      arg.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function (ctx) {
    this.allObjects().forEach(function (arg) {
      arg.move();
    });
  };

  Game.prototype.wrap = function(pos) {

    var wrappedPos = [];

    if (pos[0] > Game.DIM_X) {
      wrappedPos.push(pos[0] - Game.DIM_X);
    } else if (pos[0] < 0) {
      wrappedPos.push(pos[0] + Game.DIM_X);
    } else {
      wrappedPos.push(pos[0])
    }

    if (pos[1] > Game.DIM_X) {
      wrappedPos.push(pos[1] - Game.DIM_X);
    } else if (pos[1] < 0) {
      wrappedPos.push(pos[1] + Game.DIM_X);
    } else {
      wrappedPos.push(pos[1])
    }

    return wrappedPos;
  };

  Game.prototype.checkCollisions = function () {
    for (var i = 0; i < this.allObjects().length; i++) {
      for (var j = 0; j < this.allObjects().length; j++) {
        if (i !== j) {
          if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])) {
            // alert("COLLISION");
            console.log("COLLISIONS");
            this.allObjects()[i].collideWith(this.allObjects()[j]);
          }
        }
      }
    }
  };

  Game.prototype.step = function (context) {
    this.moveObjects(context);
    this.checkCollisions();
  };

  Game.prototype.remove = function (asteroid) {
    var asteroidIndex = this.asteroids.indexOf(asteroid);
    this.asteroids.splice(asteroidIndex, 1);
  }

})();
