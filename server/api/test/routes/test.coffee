request = require 'supertest'

describe 'Test Route', ->
	url = 'http://localhost:3000'

	describe '#/test [GET]', ->
		it 'should return 200 and Object of status ', (done) ->
			request(url)
			.get("/test")
			.expect('Content-Type', /json/)
			.end (err,res) ->
				console.log res.body
				res.should.have.status(200)
				res.body.should.be.an.instanceOf(Object)
				res.body.should.have.property('message')
				done()
