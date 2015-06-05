NewsReader.Views.FeedEntryItem = Backbone.CompositeView.extend({
  tagName: 'li',
  template: JST['feeds/feed_entry_item'],

  render: function () {
    var content = this.template({
      entry: this.model
    });

    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
