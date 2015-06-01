(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var view = this;
    $('.unclicked').on("click", function (el) {
      try {
        console.log(view.$el);
        if (!view.game.isOver()) {
          view.makeMove($(this));
        }
      }
      catch(err) {
        alert(err.msg);
      }
    });
  };

  View.prototype.makeMove = function ($square) {

    var x = $square.parent().attr("x");
    var y = $square.attr("y");

    this.game.playMove([x, y]);

    $square.removeClass("unclicked").addClass("clicked");
    var $piece = $('<div>').addClass('piece').addClass(this.game.currentPlayer);
    $piece.text(this.game.currentPlayer);
    $square.append($piece);

    if (this.game.isOver()) {
      $('.unclicked').removeClass('unclicked').addClass('clicked');

      if(this.game.winner() === null) {
        this.$el.append($('<h2>').text("Game is Draw"));
      } else {
        var winner = this.game.winner() === 'x' ? 'o' : 'x';
        this.$el.append($('<h2>').text("Player " + winner +" won!!!"));
        $("." + winner).parent().addClass("winner");
      }
    }
  };

  View.prototype.setupBoard = function () {
    for (var i = 0; i < 3; i++) {
      var $divRow = $('<div>').addClass('row').attr({"x": i});
      this.$el.append($divRow);
    }


    for (var j = 0; j < 3; j++) {
      var $divCell = $('<div>').addClass('cell').addClass('unclicked').attr({"y": j});
      $('.row').append($divCell);
    }
  };
})();
