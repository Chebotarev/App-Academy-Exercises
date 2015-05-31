// Stores a Game instance.
// Stores a canvas context to draw the game into.
// Installs key listeners to move the ship and fire bullets.
// Installs a timer to call Game#step.

(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function (canvasEl) {
    this.ctx = canvasEl.getContext("2d");
    this.game = new Asteroids.Game();
  };

  GameView.prototype.start = function () {
    this.bindKeyHandlers();
    window.setInterval((function () {
      this.game.draw(this.ctx);
      this.game.step(this.ctx);
    }).bind(this), 1000 / 60)
  };

  GameView.prototype.bindKeyHandlers = function () {
    var that = this;

    key('up', function() { that.game.ship.power([0, -1]); });
    key('right', function() { that.game.ship.power([1, 0]); });
    key('down', function() { that.game.ship.power([0, 1]); });
    key('left', function() { that.game.ship.power([-1, 0]); });
    // key('right', this.game.ship.power([0, 1]));
    // key('down', this.game.ship.power([1, 0]));
    // key('left', this.game.ship.power([0, -1]));
  };

})();
