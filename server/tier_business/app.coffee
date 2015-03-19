cluster = require('cluster')
winston = require 'winston'
config = require "config"
kue = require("kue")
http = require 'http'
numCPUs = require('os').cpus().length

logger = require '../lib/logger'
timeoutValue = process.env.worker_timeout or 500

if process.env.REDISTOGO_URL
	rtg   = require("url").parse(process.env.REDISTOGO_URL)
	redisOptions =
		port: rtg.port,
		host: rtg.hostname,
		auth: rtg.auth.split(":")[1]
else
	redisOptions =
		port: 6379
		host: '127.0.0.1'

uiToBusiness = kue.createQueue({
	prefix: 'u2b',
	redis: redisOptions
})
businessToData = kue.createQueue({
	prefix: 'b2d',
	redis: redisOptions
})


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
