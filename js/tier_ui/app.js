(function() {
  var api, bodyParser, config, express, jobQueue, kue, loaderIoRoute, logger, morgan, uiToBusiness, winston;

  winston = require('winston');

  config = require("config");

  express = require('express');

  bodyParser = require('body-parser');

  morgan = require('morgan');

  logger = require('../lib/logger');

  jobQueue = require('../lib/jobQueue');

  uiToBusiness = jobQueue.uiToBusiness;

  loaderIoRoute = '/' + (process.env.LOADERIO_TOKEN || 'bad-route') + '/';

  kue = require('kue');

  process.title = "api";

  logger.info("--UI tier starting--");

  api = exports.api = express();

  api.use(morgan('dev', {
    immediate: true
  }));

  api.use(express["static"](__dirname + '/app'));

  api.use(bodyParser.json());

  api.use(bodyParser.urlencoded({
    extended: true
  }));

  api.use(kue.app);

  api.use(function(req, res, next) {
    if (!req.get('Origin')) {
      return next();
    }
    res.header("Access-Control-Allow-Origin", "*");
    res.header({
      "Access-Control-Allow-Methods": 'PUT, GET, POST, DELETE'
    });
    res.header({
      "Access-Control-Allow-Headers": 'X-Requested-With, Authorization, Content-Type'
    });
    res.contentType('application/json');
    if ('OPTIONS' === req.method) {
      return res.status(200).send();
    }
    return next();
  });

  api.get(loaderIoRoute, function(req, res, next) {
    res.status(200);
    return res.send(process.env.LOADERIO_TOKEN);
  });

  api.get('/api/test', function(req, res, next) {
    var job;
    job = uiToBusiness.create("email", {
      title: "welcome email for tj",
      to: "tj@learnboost.com",
      template: "welcome-email"
    });
    job.on('complete', function(result) {
      logger.info("job with id " + job.id + " completed");
      res.status(200);
      res.send({
        message: "OK"
      });
      return res.end();
    });
    job.on('failed', function() {
      logger.info("job with id " + job.id + " failed");
      res.status(500);
      return res.send({
        message: "Error"
      });
    });
    return job.save();
  });

  process.once("SIGINT", function(sig) {
    return uiToBusiness.shutdown((function(err) {
      logger.info("API is shut down.", err || "");
      return process.exit(0);
    }), 5000);
  });

  process.once("SIGTERM", function(sig) {
    return uiToBusiness.shutdown((function(err) {
      logger.info("API is shut down.", err || "");
      return process.exit(0);
    }), 5000);
  });

}).call(this);
