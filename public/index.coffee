express = require 'express'
morgan = require 'morgan'

app = express()
app.use morgan('dev', immediate: true)

app.use(express.static(__dirname + '/app'))

app.listen(8000)

console.log "api ide na dobrej ceste"
