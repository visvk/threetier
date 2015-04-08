(function() {
  var float, int;

  module.exports = {
    listen_ip: '127.0.0.1',
    listen_port: int(process.env.PORT) || 3000,
    max_sockets: int(process.env.PORT) || Infinity,
    base_url: process.env.BASE_URL || 'http://localhost:3000',
    concurrency: int(process.env.CONCURRENCY) || 1
  };

  int = function(str) {
    if (!str) {
      return 0;
    }
    return parseInt(str, 10);
  };

  float = function(str) {
    if (!str) {
      return 0;
    }
    return parseFloat(str, 10);
  };

}).call(this);
