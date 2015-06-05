NewsReader.Models.Entry = Backbone.Model.extend({
  url: function () {
    debugger;
    return this.feed.url() + '/entries';
    }.bind(this),
});
