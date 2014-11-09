cluster = require('cluster')
winston = require 'winston'
config = require "config"
kue = require("kue")
jobs = kue.createQueue()
numCPUs = require('os').cpus().length

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

if cluster.isMaster

	# Fork workers.
	i = 0

	while i < numCPUs
		cluster.fork()
		i++

	cluster.on "exit", (worker, code, signal) ->
		console.log "worker " + worker.process.pid + " died"
		return
else

	logger.info "Worker starting"
	jobs.process "email", 10, (job, done) ->
		logger.info "In job queue", job.data
		setTimeout( () ->
			logger.info "completed #{job.id}"
			done(null, [0, 2, 4, 6])
		, 500)

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
