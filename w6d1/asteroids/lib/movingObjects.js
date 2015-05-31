// Base class for anything that moves.
// Most important methods are #move, #draw(ctx), #isCollidedWith(otherMovingObject).

(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var MovingObject = Asteroids.MovingObject = function(pos, vel, radius, color) {
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.color = color;
  };

  MovingObject.prototype.draw = function (ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
     this.pos[0],
     this.pos[1],
     this.radius,
     0,
     2 * Math.PI,
     false
   );

   ctx.fill();
  };

  MovingObject.prototype.move = function () {
    var deltaX = this.pos[0] + this.vel[0];
    var deltaY = this.pos[1] + this.vel[1];

    this.pos = this.game.wrap([deltaX, deltaY]);
  };

  MovingObject.prototype.isCollidedWith = function (otherObject) {
    var distance = Math.sqrt(
      Math.pow((this.pos[0] - otherObject.pos[0]), 2) +
      Math.pow((this.pos[1] - otherObject.pos[1]), 2)
    )

    if (distance <= ( this.radius + otherObject.radius )) {
      return true;
    } else {
      return false;
    }
  };

  MovingObject.prototype.collideWith = function(otherObject) {
    // this.game.remove(otherObject);
    // this.game.remove(this);
  }
})();
