(function() {
  var businessToData, cluster, config, http, jobQueue, kue, logger, numCPUs, start, timeoutValue, winston;

  cluster = require('cluster');

  winston = require('winston');

  config = require("config");

  kue = require("kue");

  http = require('http');

  numCPUs = require('os').cpus().length;

  logger = require('../lib/logger');

  jobQueue = require('../lib/jobQueue');

  businessToData = jobQueue.businessToData;

  timeoutValue = process.env.worker_timeout || 0;

  module.exports = {
    start: function() {
      return start();
    },
    close: function() {
      return businessToData.shutdown((function(err) {
        logger.info("Data tier has shut down.", err || "");
        return process.exit(0);
      }), 5000);
    }
  };

  start = function() {
    logger.info("--Data tier starting--");
    return businessToData.process("create email", 20, function(job, done) {
      logger.info("In Data tier with job ", job.data);
      return setTimeout(function() {
        logger.info("completed " + job.id);
        return done(null, [0, 2, 4, 6]);
      }, timeoutValue);
    });
  };

  process.once("SIGINT", function(sig) {
    return businessToData.shutdown((function(err) {
      logger.info("Data tier has shut down.", err || "");
      return process.exit(0);
    }), 5000);
  });

  process.once("SIGTERM", function(sig) {
    return businessToData.shutdown((function(err) {
      logger.info("Data tier has shut down.", err || "");
      return process.exit(0);
    }), 5000);
  });

}).call(this);
