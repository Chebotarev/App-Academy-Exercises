$.Carousel = function (el) {
  this.$el = $(el);
  this.$activeIdx = 0;
  this.$images = this.$el.find('.items').children();
  this.$images.eq(0).addClass('active');
  this.transitioning = false;

  $('.slide-right').on('click', this.moveRight.bind(this));
  $('.slide-left').on('click', this.moveLeft.bind(this));

};

$.Carousel.prototype.move = function (inc, dir) {
  if (this.transitioning) {
    return;
  }
  this.transitioning = true;
  var $oldImage = this.$images.eq(this.$activeIdx);
  this.$activeIdx = (this.$activeIdx + inc) % this.$images.length;
  var $newImage = this.$images.eq(this.$activeIdx);
  $newImage.addClass('active').addClass(dir);
  var oppDir = dir === "left" ? "right" : "left";
  $oldImage.addClass(oppDir);

  setTimeout(function () {
    $newImage.removeClass(dir);
    $newImage.one("transitionend", function () {
      $oldImage.removeClass("active").removeClass(oppDir);
      this.transitioning = false;
    }.bind(this));
  }.bind(this), 0);
};

$.Carousel.prototype.moveRight = function() {
  this.move(-1, "right");
};

$.Carousel.prototype.moveLeft = function() {
  this.move(1, "left");
};

$.fn.carousel = function() {
  return this.each(function(el) {
    new $.Carousel(this);
  }.bind(this));
};
