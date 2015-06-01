$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find('input');
  this.$results = this.$el.find('ul.users');
  this.$input.on("input", this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (event) {
  var queryString = $(event.currentTarget).val();
  $.ajax({
    url: "/users/search?query=" + queryString,
    data: { query: queryString },
    dataType: "json",
    success: this.renderResults.bind(this)
  });
};

$.UsersSearch.prototype.renderResults = function (response) {
  this.$results.empty();
  response.forEach(function (result) {
    var $newResult = $('<li>');
    var $newLink = $('<a>').attr('href', "/users/" + result.id  ).text(result.username);
    var $newButton = $('<button>').addClass('toggle-follow');
    var followed = result.followed ? "followed" : "unfollowed";
    // $newButton.attr('data-user-id', result.id);
    // $newButton.attr('data-initial-follow-state', followed);
    // debugger;
    $newButton.followToggle({ userId: result.id, followState: followed});


    $newResult.append($newLink).append($newButton);
    $newResult.appendTo(this.$results);
  }.bind(this));
};

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $("div.users-search").usersSearch();
});
