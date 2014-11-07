winston = require 'winston'
config = require "config"
express = require 'express'
bodyParser = require 'body-parser'
morgan = require 'morgan'
kue = require('kue')
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

api.listen(3000)
logger.info "API is running on port 3000"

process.once "SIGINT", (sig) ->
	logger.info "API shutdown"
	process.exit 0

process.once "SIGTERM", (sig) ->
	logger.info "API shutdown"
	process.exit 0