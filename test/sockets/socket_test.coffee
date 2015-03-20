should = require 'should'
io = require('socket.io-client')
serverHelper = require '../helpers/server'
config = require 'config'

server = null
ENV_PORT = process.env.PORT or config.main.listen_port

options =
  transports: ['websocket'],
  'force new connection': true

describe 'Test Socket', ->
  url = 'http://localhost:' + ENV_PORT

  before (done)->
    server = serverHelper.createServer done

  after (done)->
    server.close()
    console.log "test server closed"
    done()


  it '#should emit test.response socket', (done) ->
    client = io.connect url, options
    client.on 'connect', (data) ->
      client.emit 'test', title: "Testing", body: "testing body"

      client.on 'test.response', (data) ->
        data.should.be.an.instanceOf(Object)
        data.should.have.property('title')
        data.should.have.property('body')
        done()
