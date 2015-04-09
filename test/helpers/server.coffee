app = require('../../tier_ui/app').api
businessTier = require('../../tier_business/app')
dataTier = require('../../tier_data/app')
config = require('config')

UITier = null
ENV_PORT = process.env.PORT or 8080


module.exports =
  createServer: (done) ->
    createServer(done)
  closeServer: (done) ->
    closeServer(done)
  getHeaders: (type, path) ->
    getHeaders(type, path)
  getBaseUrl: () ->
    getBaseUrl()


createServer = (done)->
  UITier = require('http').createServer(app)
  businessTier.start()
  dataTier.start()

  require('../../tier_ui/socket_app')(app, UITier)

  UITier.listen ENV_PORT, (error, result)->
    if error
      done error
    else
      done()


closeServer = (done) ->
  if UITier then UITier.close()
#  if businessTier then businessTier.close()
#  if dataTier then dataTier.close()
  setTimeout(->
    done()
  , 100)


getHeaders = (type, path)->
  headers =
    "host": "127.0.0.1",
    "port": '3000',
    "path": path,
    "method": type,
    "headers": {}


getBaseUrl = () ->
  'http://localhost:' + ENV_PORT