function Board() {
  this.grid = [[],[],[]];
}

Board.WIN_CONDITIONS = [
  [[0, 0], [0, 1], [0, 2]],
  [[1, 0], [1, 1], [1, 2]],
  [[2, 0], [2, 1], [2, 2]],
  [[0, 0], [1, 0], [2, 0]],
  [[0, 1], [1, 1], [2, 1]],
  [[0, 2], [1, 2], [2, 2]],
  [[0, 0], [1, 1], [2, 2]],
  [[0, 2], [1, 1], [2, 0]],
];

Board.prototype.print = function () {
  for (var i = 0; i < this.grid.length; i++) {
    for (var j = 0; j < 3; j++) {
      if (this.pieceAt([i, j]) === undefined) {
        process.stdout.write("_");
      } else {
        process.stdout.write(this.pieceAt([i, j]));
      }
    }
    console.log("");
  }
};

Board.prototype.isWon = function () {
  var won = false;
  var that = this;
  Board.WIN_CONDITIONS.forEach( function(winCondition) {
    if ((that.pieceAt(winCondition[0]) !== undefined) &&
    (that.pieceAt(winCondition[0]) === that.pieceAt(winCondition[1])) &&
    (that.pieceAt(winCondition[0]) === that.pieceAt(winCondition[2]))) {
      won = true;
    }
  });

  return won;
};

Board.prototype.isStalemate = function () {
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (this.pieceAt([i, j]) === undefined) {
        return false;
      }
    }
  }
  return true;
};

Board.prototype.pieceAt = function (pos) {
  return this.grid[pos[0]][pos[1]];
};

module.exports = Board;
