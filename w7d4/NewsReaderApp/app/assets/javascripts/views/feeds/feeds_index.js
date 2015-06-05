NewsReader.Views.FeedsIndex = Backbone.CompositeView.extend({

  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, 'reset', this.addViews);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addFeedsIndexItemView: function (feed) {
    var subview = new NewsReader.Views.FeedsIndexItem({ model: feed });
    this.addSubview('.feeds', subview);
  },

  addViews: function () {
    this.collection.each( function (feed) {
      this.addFeedsIndexItemView(feed);
    }, this);
  }
});
