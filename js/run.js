(function() {
  require('newrelic');

  require('./tier_ui/run');

  require('./tier_business/run');

  require('./tier_data/run');

}).call(this);
