# SOCKETIO
socketio = require 'socket.io'
redisSocket = require 'socket.io-redis'
logger = require '../lib/logger'

module.exports = (app, server) ->
  # socket.io conf
  io = socketio.listen(server)

  if process.env.REDISTOGO_URL
    rtg = require("url").parse(process.env.REDISTOGO_URL)
    io.adapter redisSocket({host: rtg.hostname, port: rtg.port, auth_pass: rtg.auth.split(":")[1]})
  else
    io.adapter redisSocket({host: 'localhost', port: 6379})

  console.log "Socket server running"

  app.set('socketio', io)
  app.set('server', server)

  io.on 'connection', (socket) ->
    socket.on 'my other event', (data) ->
      logger.info data
    socket.on 'test', (data) ->
      logger.info "test, next -> test.response"
      socket.emit('test.response', data)
      socket.broadcast.emit('test.response', data)