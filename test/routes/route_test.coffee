request = require 'supertest'
should = require 'should'
async = require 'async'
serverHelper = require '../helpers/server'
config = require 'config'

server = null
url = ''

describe 'Test Route', ->
  before (done)->
    url = serverHelper.getBaseUrl()
    server = serverHelper.createServer done

  after (done)->
    serverHelper.closeServer(done)

  describe '#/test [GET] ', (done) ->
    it "should return 200 and Object of status", (done) ->
      request(url)
      .get("/api/test")
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        console.log err
        if err then throw err
        res.body.should.be.an.instanceOf(Object)
        res.body.should.have.property('message')
        done()