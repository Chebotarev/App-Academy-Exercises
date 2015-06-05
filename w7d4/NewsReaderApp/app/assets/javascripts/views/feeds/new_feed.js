NewsReader.Views.NewFeed = Backbone.View.extend({
  events: {
    'submit form': 'handleForm'
  },

  template: JST['feeds/new_feed'],

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  handleForm: function (event) {
    event.preventDefault();

    var formData = $(event.currentTarget).serializeJSON();

    var feed = new NewsReader.Models.Feed(formData.feed);
    feed.save({}, {
      success: function () {
        NewsReader.feeds.add(feed);
        Backbone.history.navigate('#/feeds/' + feed.id, { trigger: true });
      }
    });
  }
});
