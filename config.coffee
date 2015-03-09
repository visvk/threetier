module.exports =
  listen_ip: '127.0.0.1'
  listen_port: int(process.env.PORT) or 3000
  max_sockets: int(process.env.PORT) or Infinity
  base_url: process.env.BASE_URL or 'http://localhost:3000'
  concurrency: int(process.env.CONCURRENCY) or 1


int = (str) ->
  if not str
    return 0
  parseInt str, 10


float = (str) ->
  if not str
    return 0
  parseFloat str, 10
