winston = require 'winston'
config = require "config"

process.title = "api"

logger = new (winston.Logger)(
	transports: [
		new winston.transports.Console
			level: config.get("logger.console_log_level")
			colorize: true
			timestamp: true
			handleExceptions: true
	]
)
global.logger = logger

logger.info "API starting"

process.once "SIGTERM", (sig) ->
	logger.info "API shutdown"
	process.exit 0
