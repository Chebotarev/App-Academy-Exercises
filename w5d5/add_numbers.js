var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question ("Enter a number:", function(answer){
      var number = parseInt(answer);
      sum += number;
      numsLeft -= 1;
      console.log("The current partial sum is: " + sum );
      addNumbers(sum, numsLeft, completionCallback);
    });
  } else {
    completionCallback(sum);
    reader.close();
  }
}

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
