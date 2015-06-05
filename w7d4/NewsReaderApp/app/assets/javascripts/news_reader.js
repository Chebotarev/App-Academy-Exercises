window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    NewsReader.router = new NewsReader.Routers.Router({ $rootEl: $("#content") });
    NewsReader.feeds = new NewsReader.Collections.Feeds();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
