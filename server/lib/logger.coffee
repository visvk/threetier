winston = require 'winston'
#config = require '../config'

winston.emitErrs = true
logger = new winston.Logger(
	transports: [
		new winston.transports.Console(
			level: "debug"
			handleExceptions: true
			json: false
			colorize: true
		)
	]
	exitOnError: false
)

module.exports = logger