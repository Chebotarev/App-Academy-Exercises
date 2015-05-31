var sum = function() {
  var args = Array.prototype.slice.call(arguments);
  var total = 0;
  args.forEach(function(arg) {
    total += arg;
  });

  return total;
};


Function.prototype.myBind = function(obj) {
  var args = Array.prototype.slice.call(arguments, 1);
  var func = this;
  return function () {
    return func.apply(obj, args);
  };
};

function Cat (name, age) {
  this.name = name;
  this.age = age;
}

function Dog (name, age) {
  this.name = name;
  this.age = age;
}

Cat.prototype.wagTail = function (t1, t2) {
  return (this.name + " wag's its tail." + t1 + t2);
};

var dog = new Dog('fido', 6);
var cat = new Cat('fluffy', 7);

var testBind = (Cat.prototype.wagTail).myBind(dog, 'this', 'here');

// console.log(testBind());


function curriedSum(numArgs) {
  var numbers = [];

  var _curriedSum = function (arg) {
    numbers.push(arg);
    if (numbers.length === numArgs) {
      var total = 0;
      numbers.forEach(function (arg) {
        total += arg;
      });

      return total;
    } else {
      return _curriedSum;
    }
  };

  return _curriedSum;

}

Function.prototype.curry = function(numArgs) {
  var args = [];
  var func = this;
  var _innerCurry = function (arg) {
    args.push(arg);
    if (args.length === numArgs) {
        return func.apply(func, args);
    } else {
      return _innerCurry;
    }
  };
  return _innerCurry;
};
