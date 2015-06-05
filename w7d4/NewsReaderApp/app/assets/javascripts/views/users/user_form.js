NewsReader.Views.UserForm = Backbone.View.extend({
  template: JST['users/form'],

  events: {
    'submit form':'submit'
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON().user;
    debugger
  }
});
