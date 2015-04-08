(function() {
  var app, cluster, http, logger, numCPUs, server;

  require('newrelic');

  cluster = require('cluster');

  app = require('./app').api;

  http = require('http');

  logger = require('../lib/logger');

  numCPUs = require('os').cpus().length;

  http.globalAgent.maxSockets = Infinity;

  server = app.listen(process.env.PORT || 8080);

  require('./socket_app')(app, server);

  logger.info("API is running on port " + (process.env.PORT || 8080));

}).call(this);
