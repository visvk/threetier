should = require 'should'
io = require('socket.io-client')
serverHelper = require '../helpers/server'
config = require 'config'

server = null
url = ''

options =
  transports: ['websocket'],
  'force new connection': true

describe 'Test Socket', ->
  before (done)->
    url = serverHelper.getBaseUrl()
    server = serverHelper.createServer done

  after (done)->
    serverHelper.closeServer(done)

  describe 'socket Test', (done) ->
    it '#should emit test.response socket', (done) ->
      client = io.connect url, options
      client.on 'connect', (data) ->
        client.emit 'test', title: "Testing", body: "testing body"

        client.on 'test.response', (data) ->
          data.should.be.an.instanceOf(Object)
          data.should.have.property('title')
          data.should.have.property('body')
          done()
