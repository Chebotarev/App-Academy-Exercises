(function () {

  if (typeof Hanoi === undefined) {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.clickedPile = null;

    this.findPile = function (num) {
      return function () {
        return $(this).data("num") === num;
      }
    };

    this.setupTowers();
    this.render();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var view = this;
    $('.pile').on("click", function () {
      if (!view.game.isWon()) {
        if (view.clickedPile === null) {
          view.clickedPile = $(this);
          $(this).addClass("selected")
        } else {
          view.clickTower($(this));
        }
      }
    });
  };

  View.prototype.clickTower = function (destPile) {
    this.game.move(this.clickedPile.data("num"), destPile.data("num"));
    this.clickedPile.removeClass("selected");
    this.clickedPile = null;
    this.render();
  };

  View.prototype.setupTowers = function () {
    for (var i = 0; i < 3; i++) {
      var pile = $('<div>').addClass('pile');
      pile.data("num", i);
      this.$el.append(pile);
    }


    for (var j = 1; j < 4; j++) {
      var disk = $('<div>').addClass('disk');
      disk.data("size", j);
      $('.pile').filter(this.findPile(0)).append(disk);
    }
  };

  View.prototype.render = function () {
    var game = this.game;

    $('.disk').remove();
    var disk = null;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < game.towers[i].length; j++) {
        var currentTower = game.towers[i];
        disk = $('<div>').addClass('disk');
        disk.data("size", currentTower[j]);

        if (currentTower[j] === 1) {
          disk.addClass("small");
        } else if (currentTower[j] === 2) {
          disk.addClass("medium");
        } else {
          disk.addClass("large");
        }

        $('.pile').filter(this.findPile(i)).prepend(disk);
      }
    }
  };
})();
