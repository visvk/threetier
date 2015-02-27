winston = require 'winston'
config = require "config"
express = require 'express'
http = require 'http'
bodyParser = require 'body-parser'
morgan = require 'morgan'
logger = require './lib/logger'

process.title = "api"

logger.info "Simple API starting"

api = express()
api.use morgan('dev')
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

    res.status 200
    res.send message: "OK"
    res.end()
  , 500)

http.globalAgent.maxSockets = 50
api.listen(3002)
logger.info "Simple API is running on port 3002"

process.once "SIGINT", (sig) ->
  logger.info "API is shut down."
  process.exit 0


process.once "SIGTERM", (sig) ->
  logger.info "API is shut down."
  process.exit 0