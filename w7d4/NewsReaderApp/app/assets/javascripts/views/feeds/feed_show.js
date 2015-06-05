NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  events: {
    'click .refresh': 'refresh'
  },

  template: JST['feeds/feed_show'],

  addFeedEntryItemView: function (entry) {
    var subview = new NewsReader.Views.FeedEntryItem({ model: entry });
    this.addSubview('.entries', subview );
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.model.entries().each( function (entry) {
      this.addFeedEntryItemView(entry);
    }, this);
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  refresh: function () {
    this.model.entries().each ( function (entry) {
      this.removeFeedEntryItemView (entry);
    }, this);
    this.model.fetch();
  },

  removeFeedEntryItemView: function (entry) {
    this.removeModelSubview('.entries', entry);
  }
});
