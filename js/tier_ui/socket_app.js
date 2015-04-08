(function() {
  var logger, redisSocket, socketio;

  socketio = require('socket.io');

  redisSocket = require('socket.io-redis');

  logger = require('../lib/logger');

  module.exports = function(app, server) {
    var io, rtg;
    io = socketio.listen(server);
    if (process.env.DOREDIS_URL) {
      io.adapter(redisSocket({
        host: DOREDIS_URL,
        port: 6379
      }));
    }
    if (process.env.REDISTOGO_URL) {
      rtg = require("url").parse(process.env.REDISTOGO_URL);
      io.adapter(redisSocket({
        host: rtg.hostname,
        port: rtg.port,
        auth_pass: rtg.auth.split(":")[1]
      }));
    } else {
      io.adapter(redisSocket({
        host: 'localhost',
        port: 6379
      }));
    }
    console.log("Socket server running");
    app.set('socketio', io);
    app.set('server', server);
    return io.on('connection', function(socket) {
      socket.on('my other event', function(data) {
        return logger.info(data);
      });
      return socket.on('test', function(data) {
        logger.info("test, next -> test.response");
        socket.emit('test.response', data);
        return socket.broadcast.emit('test.response', data);
      });
    });
  };

}).call(this);
