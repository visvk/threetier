request = require 'supertest'
should = require 'should'
async = require 'async'
serverHelper = require '../helpers/server'

server = null

describe 'Test Route', ->
	url = 'http://localhost:3000'

	before (done)->
		server = serverHelper.createServer done

	after (done)->
		server.close()
		console.log "test server closed"
		done()

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