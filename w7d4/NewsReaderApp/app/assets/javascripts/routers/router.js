NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    '': 'index',
    'feeds/new': 'new',
    'feeds/:id': 'feedShow',
    'session/new': 'userForm',
    'users/new': 'userForm'
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  index: function () {
    NewsReader.feeds.fetch({ reset: true });
    var view = new NewsReader.Views.FeedsIndex({ collection: NewsReader.feeds });
    this._swapView(view);
  },

  feedShow: function (id) {
    var feed = NewsReader.feeds.getOrFetch(id);
    var view = new NewsReader.Views.FeedShow({ model: feed });
    this._swapView(view);
  },

  new: function () {
    var view = new NewsReader.Views.NewFeed();
    this._swapView(view);
  },

  userForm: function () {
    var view = new NewsReader.Views.UserForm();
    this._swapView(view);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
