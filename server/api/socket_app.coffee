# SOCKETIO
socketio = require 'socket.io'
redisSocket = require 'socket.io-redis'

module.exports = (app, server) ->
  # socket.io conf
  io = socketio.listen(server)
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