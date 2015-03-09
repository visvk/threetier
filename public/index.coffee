express = require 'express'
morgan = require 'morgan'

app = express()
app.use morgan('dev')
app.use("/dp/threetier/public/", express.static(__dirname + '/app'))
app.listen(8000)
