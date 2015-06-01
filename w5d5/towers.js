var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame() {
  this.stacks = [[3, 2, 1], [], []];
}

HanoiGame.prototype.isWon = function() {
  if (this.stacks[1].length === 3 || this.stacks[2].length === 3) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx) {
  var start = this.stacks[startTowerIdx];
  var end = this.stacks[endTowerIdx];

  if (start.length === 0) {
    return false;
  } else if (end.length === 0) {
    return true;
  }

  var startTop = start[start.length - 1];
  var endTop = end[end.length - 1];

  if (this.stacks[startTowerIdx] < this.stacks[endTowerIdx]) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Enter start tower: ", function (startAnswer) {
    reader.question("Enter end tower: ", function (endAnswer) {
      callback(startAnswer, endAnswer);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  var that = this;
  this.promptMove(function (startAnswer, endAnswer) {
    if (that.move(startAnswer, endAnswer)) {
      if (that.isWon()) {
        completionCallback();
      } else {
        that.run(completionCallback);
      }
    } else {
      console.log("Invalid Move");
      that.run(completionCallback);
    }
  });
};

var hanoi = new HanoiGame();
hanoi.run(function () {
  console.log("YOU WON!!");
  reader.close();
});
// console.log(JSON.stringify([[1,2],[2,3]]));
