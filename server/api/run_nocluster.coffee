app = require('./app').api
http = require 'http'

http.globalAgent.maxSockets = 50
app.listen(3000)
logger.info "API is running on port 3000"

