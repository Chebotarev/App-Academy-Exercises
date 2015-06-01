var Board = require('./board.js');

function Game(reader){
  this.currentPlayer = "X";
  this.board = new Board();
  this.reader = reader;
}

Game.prototype.switchPlayer = function () {
  this.currentPlayer = this.currentPlayer === "X" ? "O" : "X";
};

Game.prototype.promptMove = function (reader, callback) {
  this.board.print();
  reader.question("Player " + this.currentPlayer + " enter row: ",
    function (rowAnswer) {
      reader.question("Enter column: ", function (colAnswer) {
        callback(rowAnswer, colAnswer);
      });
    }
  );
};

Game.prototype.move = function (row, col) {
  if ((row <= 2 && col <= 2) && this.board.pieceAt([row, col]) === undefined ) {
    this.board.grid[row][col] = this.currentPlayer;
    return true;
  } else {
    return false;
  }
};

Game.prototype.run = function(completionCallback) {
  var that = this;
  this.promptMove(this.reader, function (row, col) {
    if (that.move(row, col)) {
      if (that.board.isWon()) {
        completionCallback(true);
      } else if (that.board.isStalemate()) {
        completionCallback(false);
      } else {
        that.switchPlayer();
        that.run(completionCallback);
      }
    } else {
      console.log("Invalid Move");
      that.run(completionCallback);
    }
  });
};

module.exports = Game;
