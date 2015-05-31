// Utility code, especially vector math stuff.

(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var Utils = Asteroids.Utils = {};

  Utils.inherits = function (ChildClass, ParentClass) {
    function Surrogate () {}
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
  };

  Utils.randVector = function (length) {
    function getRandomArbitrary(min, max) {
      return Math.random() * (max-min) + min;
    }

    var x = getRandomArbitrary(-10, 10);
    var y = getRandomArbitrary(-10, 10);

    return [x, y];
  };
})();
