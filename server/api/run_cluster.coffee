cluster = require('cluster')
app = require('./app').api
http = require 'http'

numCPUs = require('os').cpus().length

if cluster.isMaster
	# Fork workers.
	i = 0
	while i < 2
		cluster.fork()
		i++

	cluster.on "exit", (worker, code, signal) ->
		console.log "worker " + worker.process.pid + " died"

else
	http.globalAgent.maxSockets = 50
	app.listen(3000)
	logger.info "API is running on port 3000"

