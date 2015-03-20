cluster = require('cluster')
winston = require 'winston'
config = require "config"
kue = require("kue")
http = require 'http'
numCPUs = require('os').cpus().length

logger = require '../lib/logger'
jobQueue = require '../lib/jobQueue'

timeoutValue = process.env.worker_timeout or 500
uiToBusiness = jobQueue.uiToBusiness
businessToData = jobQueue.businessToData


module.exports =
	start: () ->
		start()
	close: () ->
		uiToBusiness.shutdown ((err) ->
			businessToData.shutdown()
			logger.info "Business tier has shut down.", err or ""
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

	logger.info "--Business tier starting--"

	# Wait for messages from UI tier
	uiToBusiness.process "email", 20, (job, done) ->
		logger.info "In job queue", job.data
		# Send message to Data Tier
		createEmail = businessToData.create 'create email', job.data

		createEmail.on 'complete', (result) ->
			logger.info "completed with data #{result}"
			done(null, [0, 2, 4, 6])

		createEmail.on 'failed', ->
			logger.info "failed"
			done(null, [0, 2, 4, 6])

		createEmail.save()


process.once "SIGINT", (sig) ->
	uiToBusiness.shutdown ((err) ->
		businessToData.shutdown()
		logger.info "Business tier has shut down.", err or ""
		process.exit 0
	), 5000

process.once "SIGTERM", (sig) ->
	uiToBusiness.shutdown ((err) ->
		businessToData.shutdown()
		logger.info "Business tier has shut down.", err or ""
		process.exit 0
	), 5000
