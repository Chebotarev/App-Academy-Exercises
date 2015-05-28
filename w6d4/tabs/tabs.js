$.Tabs = function (el) {
  this.$el = $(el);
  this.$links = $('a');
  this.$panes = $('.tab-pane');
  this.$contentTabs = $('#content-tabs');
  this.$links.eq(0).addClass('active');
  this.$panes.eq(0).addClass('active');

  this.$activeLink = $('.tabs').find('a.active');
  this.$activeTab = this.$contentTabs.find('.active');


  this.$el.on('click', 'a', function (event) {
    event.preventDefault();
    this.clickTab(event);
  }.bind(this));
};

$.Tabs.prototype.clickTab = function() {
  this.$activeLink.removeClass('active');
  this.$activeTab.removeClass('active');
  this.$activeTab.addClass('transitioning');


  var $currentLink = $(event.target);
  var $currentTab = $($currentLink.attr('href'));

  this.$activeTab.one('transitionend', function() {
    this.$activeTab.removeClass('transitioning');
    this.$activeTab = $currentTab;

    this.$activeTab.addClass('transitioning');

    setTimeout(function() {
      this.$activeTab.removeClass('transitioning');
      this.$activeTab.addClass('active');
    }.bind(this), 0);

  }.bind(this));


  $currentLink.addClass('active');
  this.$activeLink = $currentLink;
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
