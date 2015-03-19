cluster = require('cluster')
app = require('./app').api
http = require 'http'

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
http.globalAgent.maxSockets = 50
server = app.listen(process.env.PORT or 3000)
#  require('./socket_app')(app, server)

logger.info "API is running on port 3000"

