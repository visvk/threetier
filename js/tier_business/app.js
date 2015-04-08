(function() {
  var businessToData, cluster, config, http, jobQueue, kue, logger, numCPUs, start, timeoutValue, uiToBusiness, winston;

  cluster = require('cluster');

  winston = require('winston');

  config = require("config");

  kue = require("kue");

  http = require('http');

  numCPUs = require('os').cpus().length;

  logger = require('../lib/logger');

  jobQueue = require('../lib/jobQueue');

  timeoutValue = process.env.worker_timeout || 500;

  uiToBusiness = jobQueue.uiToBusiness;

  businessToData = jobQueue.businessToData;

  module.exports = {
    start: function() {
      return start();
    },
    close: function() {
      return uiToBusiness.shutdown((function(err) {
        businessToData.shutdown();
        logger.info("Business tier has shut down.", err || "");
        return process.exit(0);
      }), 5000);
    }
  };

  start = function() {
    logger.info("--Business tier starting--");
    return uiToBusiness.process("email", 20, function(job, done) {
      var createEmail;
      logger.info("In job queue", job.data);
      createEmail = businessToData.create('create email', job.data);
      createEmail.on('complete', function(result) {
        logger.info("completed with data " + result);
        return done(null, [0, 2, 4, 6]);
      });
      createEmail.on('failed', function() {
        logger.info("failed");
        return done(null, [0, 2, 4, 6]);
      });
      return createEmail.save();
    });
  };

  process.once("SIGINT", function(sig) {
    return uiToBusiness.shutdown((function(err) {
      businessToData.shutdown();
      logger.info("Business tier has shut down.", err || "");
      return process.exit(0);
    }), 5000);
  });

  process.once("SIGTERM", function(sig) {
    return uiToBusiness.shutdown((function(err) {
      businessToData.shutdown();
      logger.info("Business tier has shut down.", err || "");
      return process.exit(0);
    }), 5000);
  });

}).call(this);
