Session.setDefault('counter', 0);

Template.MafrajIndex.helpers({
  counter: function () {
    return Session.get('counter');
  }
});

Template.MafrajIndex.events({
  'click button': function () {
    // increment the counter when button is clicked
    Session.set('counter', Session.get('counter') + 1);
  }
});
