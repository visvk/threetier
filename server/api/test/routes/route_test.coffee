request = require 'supertest'
should = require 'should'
async = require 'async'
serverHelper = require '../helpers/server'
config = require 'config'

server = null
ENV_PORT = process.env.PORT or config.main.listen_port

describe 'Test Route', ->
	url = 'http://localhost:' + ENV_PORT

#	before (done)->
#		server = serverHelper.createServer done
#
#	after (done)->
#		server.close()
#		console.log "test server closed"
#		done()

	describe '#/test [GET] multiple times series', ->

		async.each [0..2], (i) ->
			it "should return 200 and Object of status ##{i} attempt", (done) ->
				request(url)
				.get("/test")
				.expect('Content-Type', /json/)
				.expect(200)
				.end ( err, res) ->
					if err then throw err
					res.body.should.be.an.instanceOf(Object)
					res.body.should.have.property('message')
					done()

		, (error) ->
			if error then throw error
			console.log "AHA"