cluster = require('cluster')
winston = require 'winston'
config = require "config"
express = require 'express'
http = require 'http'
bodyParser = require 'body-parser'
morgan = require 'morgan'
kue = require('kue')
numCPUs = require('os').cpus().length
jobs = kue.createQueue()

process.title = "api"

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

logger.info "API starting"

api = express()
api.use morgan('dev')
api.use bodyParser.json()
api.use bodyParser.urlencoded({ extended: true })
api.use(kue.app)

api.use (req, res, next) ->
	if not req.get('Origin') then return next()
	res.header "Access-Control-Allow-Origin", "*"
	res.header "Access-Control-Allow-Methods": 'PUT, GET, POST, DELETE'
	res.header "Access-Control-Allow-Headers": 'X-Requested-With, Authorization, Content-Type'
	res.contentType 'application/json'
	if ('OPTIONS' == req.method) then return res.status(200).send()
	next();

api.get '/test', (req, res, next) ->
	job = jobs.create("email",
		title: "welcome email for tj"
		to: "tj@learnboost.com"
		template: "welcome-email"
	)

	job.on 'complete', (result) ->
		logger.info "job with id #{job.id} completed"
#		logger.info result
		res.status 200
		res.send message: "OK"
		res.end()

	job.on 'failed', () ->
		logger.info "job with id #{job.id} failed"
		res.status 500
		res.send message: "Error"
	job.save()

if cluster.isMaster
	# Fork workers.
	i = 0
	while i < numCPUs
		cluster.fork()
		i++

	cluster.on "exit", (worker, code, signal) ->
		console.log "worker " + worker.process.pid + " died"

else
	http.globalAgent.maxSockets = 50
	api.listen(3000)
	logger.info "API is running on port 3000"

process.once "SIGINT", (sig) ->
	jobs.shutdown ((err) ->
		logger.info "API is shut down.", err or ""
		process.exit 0
	), 5000


process.once "SIGTERM", (sig) ->
	jobs.shutdown ((err) ->
		logger.info "API is shut down.", err or ""
		process.exit 0
	), 5000
