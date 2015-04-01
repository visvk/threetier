require('newrelic')
cluster = require('cluster')
app = require('./app').api
http = require 'http'
logger = require '../lib/logger'

numCPUs = require('os').cpus().length

#if cluster.isMaster
#  # Fork workers.
#  i = 0
#  while i < 1
#    cluster.fork()
#    i++
#
#  cluster.on "exit", (worker, code, signal) ->
#    console.log "worker " + worker.process.pid + " died"
#
#else
http.globalAgent.maxSockets = Infinity
server = app.listen(process.env.PORT or 8080)
#require('./socket_app')(app, server)

logger.info "API is running on port #{process.env.PORT or 8080}"

