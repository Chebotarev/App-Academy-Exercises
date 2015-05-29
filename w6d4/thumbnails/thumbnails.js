$.Thumbnails = function(el) {
  this.$el = $(el);
  this.$activeImg = $('.gutter-images').children().eq(0);

  this.activate(this.$activeImg);
  this.setEventHandlers();
};

$.Thumbnails.prototype.setEventHandlers = function() {
  $('.gutter-images').on("click", "img", this.clickImg.bind(this));
  $('.gutter-images').on("mouseenter", "img", this.preview.bind(this));
  $('.gutter-images').on("mouseleave", "img", this.reset.bind(this));
};

$.Thumbnails.prototype.activate = function($img) {
  var $newImg = $img.clone();
  $('.active').empty();
  $('.active').append($newImg);
};

$.Thumbnails.prototype.clickImg = function (event) {
  var $event = $(event.currentTarget);
  this.$activeImg = $event;
  this.activate(this.$activeImg);
};

$.Thumbnails.prototype.reset = function () {
  this.activate(this.$activeImg);
};

$.Thumbnails.prototype.preview = function (event) {
  var $event = $(event.currentTarget);
  this.activate($event);
};


$.fn.thumbnails = function() {
  return this.each(function(el) {
    new $.Thumbnails(el);
  });
};
