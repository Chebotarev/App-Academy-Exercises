var Board = require('./index.js').Board;
var Game = require('./index.js').Game;
var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var game = new Game(reader);
game.run(function (isWon) {
  if (isWon) {
    console.log("Player " + game.currentPlayer + " wins!");
  } else {
    console.log("Cat's game!");
  }
  game.board.print();
  reader.close();
});
