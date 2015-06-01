$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  this.$el.on("click", this.handleClick.bind(this));
  this.render();
};

$.FollowToggle.prototype.render = function () {
  // debugger;
  if (this.followState === "following" || this.followState === "unfollowing") {
    this.$el.prop("disabled", true);
  } else if (this.followState === "followed") {
    this.$el.prop("disabled", false);
    this.$el.text("Unfollow!");
  } else if (this.followState === "unfollowed"){
    this.$el.prop("disabled", false);
    this.$el.text("Follow!");
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();
  if (this.followState === "unfollowed") {
    this.followState = "following";
    $.ajax({
      url: '/users/' + this.userId + "/follow",
      type: "POST",
      dataType: "json",
      success: this.toggleFollow.bind(this)
    });
  } else {
    this.followState = "unfollowing";
    $.ajax({
      url: '/users/' + this.userId + "/follow",
      type: "DELETE",
      dataType: "json",
      success: this.toggleFollow.bind(this)
    });
  }
  this.render();
};

$.FollowToggle.prototype.toggleFollow = function () {
  this.followState = this.followState === "following" ? "followed" : "unfollowed";
  this.render();
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
