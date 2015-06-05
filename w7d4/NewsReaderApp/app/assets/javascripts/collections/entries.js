NewsReader.Collections.Entries = Backbone.Collection.extend({
  initialize: function(models, options) {
    this.feed = options.feed;
  },

  url: function () {
    return this.feed.url + "/" + this.feed.id + '/entries';
  },

  model: NewsReader.Models.Entry,

  comparator: 'published_at'
});
