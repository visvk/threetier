winston = require 'winston'
config = require "config"
express = require 'express'
bodyParser = require 'body-parser'
morgan = require 'morgan'
socketio = require 'socket.io'
redisSocket = require 'socket.io-redis'
logger = require '../lib/logger'

ENV_PORT = process.env.PORT or config.main.listen_port


process.title = "api"

logger.info "Simple API starting"

api = exports.api = express()
api.use morgan('dev')
api.use(express.static(__dirname + '/app'))
api.use bodyParser.json()
api.use bodyParser.urlencoded({ extended: true })

api.use (req, res, next) ->
	if not req.get('Origin') then return next()
	res.header "Access-Control-Allow-Origin", "*"
	res.header "Access-Control-Allow-Methods": 'PUT, GET, POST, DELETE'
	res.header "Access-Control-Allow-Headers": 'X-Requested-With, Authorization, Content-Type'
	res.contentType 'application/json'
	if ('OPTIONS' == req.method) then return res.status(200).send()
	next();

api.get '/test', (req, res, next) ->
	logger.info req.query.filter?.fields
	logger.info req.query.filter?.asd
	logger.info req.query
	email =
		title: "welcome email for tj"
		to: "tj@learnboost.com"
		template: "welcome-email"

	setTimeout( () ->
		logger.info "route /test completed"
		logger.info [2, 4, 6, 8]

#
#		socketio = req.app.get('socketio')
#		message =
#		  title: "AHOI"
#		  body: "What's up?"
#
#		socketio.sockets.emit('TEST', message)
		res.status 200
		res.send message: "OK"
		res.end()
	, 500)

# socket.io conf
#io = socketio.listen(server)
#io.adapter redisSocket({ host: 'localhost', port: 6379 })
#
#api.set('socketio', io)
#api.set('server', server)
#
#io.on 'connection', (socket) ->
#  socket.on 'my other event', (data) ->
#    logger.info data
#  socket.on 'test', (data) ->
#    logger.info "test, next -> test.response"
#    socket.emit('test.response', data)
#    socket.broadcast.emit('test.response', data)


process.once "SIGINT", (sig) ->
	logger.info "API is shut down."
	#  io.
	process.exit 0


process.once "SIGTERM", (sig) ->
	logger.info "API is shut down."
	process.exit 0
