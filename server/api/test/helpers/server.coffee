app = require('../../app.coffee').api
config = require('config')


module.exports =
	createServer: (done) ->
		createServer(done)
	getHeaders: (type, path) ->
		getHeaders(type, path)
	getBaseUrl: () ->
		getBaseUrl()

createServer = (done)->
  server = require('http').createServer(app)
  require('../../socket_app')(app, server)

  server.listen '3000', (error, result)->
    if error
      done error
    else
      done()

getHeaders = (type, path)->
  headers =
    "host": "127.0.0.1",
    "port": '3000',
    "path": path,
    "method": type,
    "headers": {}