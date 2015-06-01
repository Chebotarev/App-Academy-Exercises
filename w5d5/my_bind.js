Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    fn.apply(context);
  };
};

var cat = {
  name: "Cat"
};

var dog = {
  name: "Dog"
};

function sayName() {
  console.log(this.name);
}

var fn = sayName.myBind(cat);
fn();
