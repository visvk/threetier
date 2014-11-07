winston = require 'winston'
config = require "config"
kue = require("kue")
jobs = kue.createQueue()

process.title = "Data tier"

logger = new (winston.Logger)(
	transports: [
		new winston.transports.Console
			level: config.get("logger.console_log_level")
			colorize: true
			timestamp: true
			handleExceptions: true
	]
)

global.logger = logger

logger.info "Data tier starting"
jobs.process "email", (job, done) ->
	logger.info "In job queue", job.data
	setTimeout( () ->
		logger.info "completed #{job.id}"
		done()
	, 10000)

process.once "SIGINT", (sig) ->
	jobs.shutdown ((err) ->
		logger.info "Kue is shut down.", err or ""
		process.exit 0
	), 5000

process.once "SIGTERM", (sig) ->
	jobs.shutdown ((err) ->
		logger.info "DataTier is shut down.", err or ""
		process.exit 0
	), 5000
