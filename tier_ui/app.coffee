winston = require 'winston'
config = require "config"
express = require 'express'
bodyParser = require 'body-parser'
morgan = require 'morgan'

logger = require '../lib/logger'
jobQueue = require '../lib/jobQueue'

uiToBusiness = jobQueue.uiToBusiness
loaderIoRoute = '/'+ (process.env.LOADERIO_TOKEN or 'bad-route') + '/'

kue = require('kue')


process.title = "api"
logger.info  "--UI tier starting--"

api = exports.api = express()
api.use morgan('dev', immediate: true)

api.use(express.static(__dirname + '/app'))
api.use bodyParser.json()
api.use bodyParser.urlencoded({extended: true})
api.use(kue.app)

api.use (req, res, next) ->
  if not req.get('Origin') then return next()
  res.header "Access-Control-Allow-Origin", "*"
  res.header "Access-Control-Allow-Methods": 'PUT, GET, POST, DELETE'
  res.header "Access-Control-Allow-Headers": 'X-Requested-With, Authorization, Content-Type'
  res.contentType 'application/json'
  if ('OPTIONS' == req.method) then return res.status(200).send()
  next();

api.get loaderIoRoute, (req, res, next) ->
  res.status 200
  res.send process.env.LOADERIO_TOKEN

api.get '/api/test', (req, res, next) ->
  job = uiToBusiness.create("email",
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


process.once "SIGINT", (sig) ->
  uiToBusiness.shutdown ((err) ->
    logger.info "API is shut down.", err or ""
    process.exit 0
  ), 5000


process.once "SIGTERM", (sig) ->
  uiToBusiness.shutdown ((err) ->
    logger.info "API is shut down.", err or ""
    process.exit 0
  ), 5000