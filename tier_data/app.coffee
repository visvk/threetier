cluster = require('cluster')
winston = require 'winston'
config = require "config"
kue = require("kue")
http = require 'http'
numCPUs = require('os').cpus().length

logger = require '../lib/logger'
jobQueue = require '../lib/jobQueue'

businessToData = jobQueue.businessToData
timeoutValue = process.env.worker_timeout or 500


module.exports =
	start: () ->
		start()
	close: () ->
		businessToData.shutdown ((err) ->
			logger.info "Data tier has shut down.", err or ""
			process.exit 0
		), 5000


start = () ->
#	if cluster.isMaster
#
#		# Fork workers.
#		i = 0
#
#		while i < 1
#			cluster.fork()
#			i++
#
#		cluster.on "exit", (worker, code, signal) ->
#			console.log "worker " + worker.process.pid + " died"
#			return
#
#	else

	logger.info  "--Data tier starting--"

	businessToData.process "create email", 20, (job, done) ->
		logger.info "In Data tier with job ", job.data
		setTimeout( () ->
			logger.info "completed #{job.id}"
			done(null, [0, 2, 4, 6])
		, timeoutValue)


process.once "SIGINT", (sig) ->
	businessToData.shutdown ((err) ->
		logger.info "Data tier has shut down.", err or ""
		process.exit 0
	), 5000

process.once "SIGTERM", (sig) ->
	businessToData.shutdown ((err) ->
		logger.info "Data tier has shut down.", err or ""
		process.exit 0
	), 5000
