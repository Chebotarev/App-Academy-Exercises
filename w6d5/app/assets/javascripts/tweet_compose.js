$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$inputs = this.$el.find(':input');
  this.charCount = 0;
  this.$el.on("submit", this.submit.bind(this));
  this.$el.find('textarea').on('input', this.countChars.bind(this));
};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();
  var formData = this.$el.serializeJSON();

  this.$inputs.prop("disabled", true);
  $.ajax({
    type: "POST",
    url: "/tweets",
    dataType: "json",
    data: formData + { "char_count": this.charCount },
    success: this.handleSuccess.bind(this)
  });
};

$.TweetCompose.prototype.clearInput = function () {
  this.$el.find('textarea').val('');
};

$.TweetCompose.prototype.handleSuccess = function (response) {
  this.$inputs.prop("disabled", false);
  this.clearInput();
  $('<li>').text(JSON.stringify(response)).prependTo(this.$el.data('tweets-ul'));
};

$.TweetCompose.prototype.countChars = function (event) {
  this.charCount = $(event.currentTarget).val().length;
  var notification = this.$el.find('.chars-left');

  if (this.charCount <= 140) {
    notification.text( (140 - this.charCount) + " chars remaining!");
  } else {
    notification.text( (this.charCount - 140) + " chars over!");
  }
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $('form.tweet-compose').tweetCompose();
});
