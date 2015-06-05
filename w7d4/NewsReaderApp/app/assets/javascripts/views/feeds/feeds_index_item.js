NewsReader.Views.FeedsIndexItem = Backbone.CompositeView.extend({
  template: JST['feeds/feeds_index_item'],

  events: {
    'click .delete-feed': 'delete'
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  },

  delete: function () {
    this.model.destroy();
    this.remove();
  }
});
